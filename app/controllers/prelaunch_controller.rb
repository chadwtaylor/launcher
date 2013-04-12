
class PrelaunchController < ApplicationController
	helper ApplicationHelper

	layout 'prelaunch'

	def index
	end

	def subscribe_submit

		h = Hominid::API.new(ENV['MAILCHIMP_API_KEY'])
    x = nil
    errors = ""

		if TaylorTools::Validation.is_email_valid?(params[:email])
	    begin
	      x = h.list_subscribe(ENV['MAILCHIMP_LIST_GENERAL'], params[:email], {}, 'html', true, false, false, false)
	    rescue
	      errors = $!.to_s
	    end
	  else
	  	errors = "Invalid email address"
	  end

	  errors = nil if errors.include? "already subscribed"

    render :update do |page|
      if errors.present?
				page << "$('html.prelaunch .flash').html('#{errors}').show()"
      else
				page << "$('html.prelaunch .flash, html.prelaunch .email_input').hide()"
				page << "$('html.prelaunch .referral').show()"
				# track_visitor_data must be sent in first BEFORE sending track_event, or it won't work
				page << "track_visitor_data('email','#{params[:email]}')"
				page << "track_visitor_data('name','#{params[:email]}')"
				page << "track_event('subscribed', {email:'#{params[:email]}'})" # IMPORTANT: fire this last!
      end
    end

	end

end
