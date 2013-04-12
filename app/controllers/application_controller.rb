require 'taylor_tools'
require 'taylor_tools/validation'
require 'taylor_tools/american_states'

require 'money'
require 'money/card'
require 'money/charge'
require 'money/invoice'
require 'money/token'

class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :flash_to_headers

  def aside_enabled?
  	return @aside
  end
 	helper_method :aside_enabled?

 	def flash_to_headers
	  return unless (request.xhr? && request.xhr? == 0) # test if ajax
    flash_json = Hash[flash.map{|k,v| [k,ERB::Util.h(v)] }].to_json
    response.headers['X-Flash-Messages'] = flash_json
    flash.discard
	end

  def subscribe(email)

    h = Hominid::API.new(ENV['MAILCHIMP_API_KEY']) # MailChimp
    x = nil
    errors = ""

    begin
      x = h.list_subscribe(ENV['MAILCHIMP_LIST_BACKERS'], email, {}, 'html', true, false, false, false) # 4941b39a8a = Crown Funding Campaign List
    rescue
      flash[:error] = $!.to_s
    end

  end

 	private

 		def enable_aside
 			@aside = true
 		end

end
