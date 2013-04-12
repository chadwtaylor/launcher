class LegalsController < ApplicationController

	layout 'subpage'
	# before_filter :enable_aside

	def index
	end

	def privacy_policy
		@title = "Privacy Policy"
	end

	def terms_of_use
		@title = "Terms of Use"
	end

end
