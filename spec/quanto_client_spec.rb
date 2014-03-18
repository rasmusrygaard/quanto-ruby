require 'spec_helper'
require 'oauth'

describe Quanto::Client do

  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }
  let(:client) { Quanto::Client.new(consumer_key, consumer_secret, options) }

  describe '#initialize' do

    let(:client) { Quanto::Client.new(consumer_key, consumer_secret, options) }

    it 'constructs an OAuth2 consumer' do
      expect(OAuth2::Client).to receive(:new)
      Quanto::Client.new(consumer_key, consumer_secret)
    end

    it 'passes consumer credentials' do
      expect(OAuth2::Client).to receive(:new).with(consumer_key, consumer_secret, anything)
      Quanto::Client.new(consumer_key, consumer_secret)
    end

    it 'passes the quanto URL' do
      expect(OAuth2::Client).to receive(:new) do |key, secret, options|
        expect(options[:site]).to eq('http://quanto.herokuapp.com')
      end
      Quanto::Client.new(consumer_key, consumer_secret)
    end

  end

  describe '#access_token' do


    context 'without credentials' do

      let(:options) { {} }

      it 'returns nil' do
        expect(client.send(:access_token)).to be_nil
      end

    end

    context 'with credentials' do

      let(:options) { { access_token: 'token' } }

      it 'creates an access token' do
        expect(OAuth2::AccessToken).to receive(:new)
        client.send(:access_token)
      end

      it 'passes the consumer' do
        expect(OAuth2::AccessToken).to receive(:new).with(anything, options[:access_token])
        allow(client).to receive(:consumer).and_return(double('OAuth2::Client'))
        client.send(:access_token)
      end

    end

  end

  describe '#post' do

    let(:options) { { access_token: 'token' } }
    let(:token) { double('OAuth2::AccessToken') }

    before(:each) do
      allow(client).to receive(:access_token).and_return(token)
    end

    it 'prepends /api/v1' do
      path = 'foo'
      prefix = "/api/v1/"
      expect(token).to receive(:post).with("#{prefix}#{path}", anything).and_return ('[]')
      client.send(:post, path, {})
    end

  end

end
