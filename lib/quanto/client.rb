module Quanto
  class Client

    API_VERSION = "1"
    QUANTO_URL = "http://quanto.herokuapp.com"

    def initialize(consumer_key, consumer_secret, options = {})
      @consumer =
        OAuth2::Client.new(consumer_key, consumer_secret, site: QUANTO_URL )

      @token = options[:access_token]
    end

    # Returns true if the user is authorized to make requests to quanto
    # This means that the application has acquired a valid access token and access token secret.
    def authorized?
      !@token.nil?
    end

    def connected?
      !@access_token.nil?
    end

    private
    def access_token
      return nil unless authorized?
      @access_token ||= OAuth2::AccessToken.new(@consumer, @token)
    end

    def post(path, options)
      options[:date] ||= Date.today.to_s
      access_token.post(path, options)
    end

  end
end
