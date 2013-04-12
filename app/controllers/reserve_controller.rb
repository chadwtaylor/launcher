class ReserveController < ApplicationController

	layout 'subpage'
	before_filter :enable_ssl
	before_filter :check_pledge_session, only:[:email, :tshirt, :contribution, :card, :shipping, :confirm]
	before_filter :get_pledge_session
	after_filter :save_pledge_session, only:[:reward_submit, :email_submit, :contribution_submit, :tshirt_submit, :card_submit, :shipping_submit]
	# before_filter :enable_aside

	def index
		session[:pledge] = nil
		redirect_to "/reserve/reward"
	end

	def reward
		@rewards = Reward.order(:index)
		orders = Order.limited_backers.count(group:"reward_id")
		@limited_backers = Hashie::Mash.new
		@backers_counter = Order.backers_summary

		orders.each do |id,count|
			@limited_backers[id.first] = count
		end
	end

	def reward_submit
		@pledge = Hashie::Mash.new
		rid = params[:reward][:id]
		reward = Reward.find rid rescue (flash[:error] = "The given reward id [#{rid}]}] does not exist")

		if flash.present?
			render :update do |page|
				page.redirect_to "/reserve"
			end
			return
		end

		@pledge.reward = reward

		render :update do |page|
			if reward.supporter?
				page.redirect_to "/reserve/contribution"
			else
				page.redirect_to "/reserve/email"
			end
		end

	end

	def email
	end

	def email_submit

		unless TaylorTools::Validation.is_email_valid?(params[:email])
			render :update do |page|
				flash[:error] = "The email entered is invalid."
			end
			return
		end

		@pledge.email = params[:email]

		render :update do |page|
			if @pledge.reward.tshirt_included
				page.redirect_to "/reserve/tshirt"
			else
				page.redirect_to "/reserve/card"
			end
		end

	end

	def tshirt
	end

	def tshirt_submit
		@pledge.tshirt_size = params[:tshirt_size]
		render :update do |page|
			page.redirect_to "/reserve/card"
		end
	end

	def contribution
	end

	def contribution_submit

		c = params[:contribution]
		c = c.gsub("$", "")
		c = c.split(".").first
		@pledge.contribution = c.to_i * 100

		render :update do |page|
			if @pledge.contribution <= 0
				flash[:error] = "Please enter $1 or more to continue."
			else
				page.redirect_to "/reserve/email"
			end
		end

	end

	def card
	end

	def card_submit

		unless params[:card][:zip_code]
			render :update do |page|
				flash[:error] = "Zip code is required."
			end
			return
		end

		session[:geo] = nil

		geo = nil

		if ENV['GEOCODER_API_KEY'].present?
			geo = Geocoder.search params[:card][:zip_code]
			geo = geo.first rescue nil
			country = geo.country rescue ""
		end

		unless ENV['ALLOW_INTERNATIONAL_ORDERS']
			if geo.nil? || country.upcase != ENV['COUNTRY_RESTRICTION'].upcase
				render :update do |page|
					flash[:error] = "International shipping is unavailable.".html_safe
				end
				return
			end
		end

		session[:geo] = geo

		@pledge.card = params[:card].to_mash
		stripe_customer = Money::Card.create(params[:card].to_mash) rescue nil
		@pledge.order!.stripe_customer = stripe_customer

		render :update do |page|
			page.redirect_to "/reserve/shipping"
		end

	rescue => e
		flash[:error] = e.message.gsub("security code", "CVC")
		if e.message.include?("Unexpected error communicating") && Rails.env.development?
			flash[:error] = nil
		end
		render :update do |page|
			# page.redirect_to "/reserve/shipping" if Rails.env.development?
		end
	end

	def shipping

		reward = Reward.find @pledge.reward.id
		redirect_to "/reserve/confirm" unless reward.is_shipable

		# geo = Geocoder.search @pledge.card.zip_code
		# geo = geo.first rescue nil
		@geo = session[:geo]
		geo = session[:geo]
		@shipping = Hashie::Mash.new

		if geo
			@shipping.city = geo.city
			@shipping.state = geo.state_code
			@shipping.zip_code = @pledge.card.zip_code
		end

	end

	def shipping_submit

		s = params[:shipping].to_mash
		@pledge.shipping = s

		errors = []
		errors << "street" if s.street1.blank?
		errors << "city" if s.city.blank?
		errors << "state" if s.state.blank?
		errors << "zip_code" if s.zip_code.blank?
		flash[:error] = "The following fields are required: #{errors.join(", ")}" if errors.present?

		render :update do |page|
			unless flash[:error]
				page.redirect_to "/reserve/confirm"
			end
		end

	end

	def confirm
		# This makes sure no one alters the reward information through GET or POST
		# and keeps the reward as originally definied
		@reward = Reward.find @pledge.reward.id
		@pledge.reward.amount = @reward.amount
		@pledge.reward.subject = @reward.subject
		@pledge.reward.summary = @reward.summary
		@pledge.reward.amount = @pledge.contribution if @reward.supporter?
	end

	def confirm_submit

		person = Person.where(email:@pledge.email).first rescue nil

		unless person
			person = Person.new
			person.email = @pledge.email
			person.save
		end

		shipping = Address.new @pledge.shipping
		shipping.save

		order = Order.new @pledge.order
		order.person = person
		order.reward_id = @pledge.reward.id
		order.shipping_address = shipping
		order.contribution_amount = @pledge.contribution if @pledge.contribution.present?
		order.tshirt_size = @pledge.tshirt_size if @pledge.tshirt_size.present?
		order.save

		ReserveMailer.reserved(order).deliver #rescue nil

		subscribe(@pledge.email) # ApplicationController.subscribe
		subject = @pledge.reward.subject
		email = @pledge.email
		@pledge = nil
		session[:pledge] = "done"

		render :update do |page|
			# page << "track_visitor_data('email','#{email}')"
			# page << "track_visitor_data('name','#{email}')"
			# page << "track_event('backer',{item:'#{subject}'})"
			page.redirect_to "/reserve/done"
		end

	end

	def done
		if session[:pledge] == "done"
			session[:pledge] = nil
			return
		end

		redirect_to "/reserve"

	end

	private

		def get_pledge_session
			@pledge = session[:pledge]
		end

		def save_pledge_session
			session[:pledge] = @pledge
		end

		def check_pledge_session
			redirect_to "/reserve" if session[:pledge].blank?
		end

		def enable_ssl
			return unless ENV['SSL_ENABLED']
			return if request.url.include? "localhost"
			return unless Rails.env.production?
			return redirect_to protocol:'https' unless request.ssl?
		end

end
