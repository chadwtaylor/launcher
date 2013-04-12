if ENV['GEOCODER_API_KEY'].present?

  Geocoder.configure do |config|

    # ######################################################################################################
    # REGISTER WITH https://www.bingmapsportal.com
    # ######################################################################################################

    # geocoding service (see below for supported options):
    config.lookup = :bing
    config.api_key = ENV['GEOCODER_API_KEY']

    # geocoding service request timeout, in seconds (default 3):
    config.timeout = 5

    # set default units to kilometers:
    # config.units = :km

    # caching (see below for details):
    # config.cache = Redis.new
    # config.cache_prefix = "..."

    puts ">> GEOCODER ENABLED USING #{config.lookup}"

  end


end
