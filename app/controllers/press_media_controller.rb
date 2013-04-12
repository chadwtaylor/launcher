class PressMediaController < ApplicationController

	layout 'subpage'
	before_filter :enable_aside

	def index
		@title = "Press & Media"
	end

end
