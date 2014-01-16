module Quanto
  class Client

    API_VERSION = "1"
    QUANTO_URL = "http://quanto.herokuapp.com"

    def initialize(consumer_key, consumer_secret, options = {})
      @consumer =
        OAuth::Consumer.new(consumer_key, consumer_secret, site: QUANTO_URL )

      @token = options[:access_token]
      @token_secret = options[:access_token_secret]
    end

    # Returns true if the user is authorized to make requests to quanto
    # This means that the application has acquired a valid access token and access token secret.
    def authorized?
      !@token.nil? && !@token_secret.nil?
    end

    def connected?
      !@access_token.nil?
    end

    private
    def access_token
      return nil unless authorized?
      @access_token ||= OAuth::AccessToken.new(@consumer, @token, @token_secret)
    end

  end
end
