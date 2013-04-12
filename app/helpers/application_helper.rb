module ApplicationHelper

	def contact_us_link(label="Contact Us", wrapper=nil)
		if ENV["ZENDESK_DROPBOX_ID"].present?
			return link_to label, ENV["ZENDESK_URL"], onclick:"Zenbox.render(); return false;"
		end
		return link_to label, "mailto:#{ENV["SUPPORT_EMAIL"]}"
	end

	def generate_head_title
		title = @title
		action = params[:action].gsub("_"," ")
		ctrl = params[:controller].gsub("_"," ")

		unless title
			if action == "index"
				title = ctrl.titleize
			else
				title = "#{action.titleize}"
			end
		end

		return "#{title} | #{ENV['ORGANIZATION']} | #{ENV['TAGLINE']}"
	end

	def campaign_days_left
		last_day = Date.parse ENV['CROWDFUNDING_DEADLINE']
		today = Date.today
		return last_day.mjd - today.mjd
	end

	def crowdfunding_deadline
		d = Date.parse(ENV['CROWDFUNDING_DEADLINE'])
		return d.strftime('%A, %B %d, %Y')
	end

	def tshirt_size_to_human(size)
		size = size.split("-")
		gender = size[0] == "W" ? "Women" : "Men"
		size = size[1]
		return "#{gender} '#{size}'"
	end

end
