class HowItWorksController < ApplicationController

	layout 'subpage'
	# before_filter :redirect_to_about
	# before_filter :enable_aside

	def index
		@title = "See How NeverFold Works"
	end

end
