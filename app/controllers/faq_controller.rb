class FaqController < ApplicationController

	layout 'subpage'
	# before_filter :redirect_to_about
	before_filter :enable_aside

	def index
		@title = "FAQ"
	end

	def redirect_to_about
		redirect_to "/about"	
	end

end
