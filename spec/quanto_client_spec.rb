require 'spec_helper'
require 'oauth'

describe Quanto::Client do

  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }

  describe '#initialize' do

    it 'constructs an OAuth2 consumer' do
      OAuth2::Client.should_receive(:new)
      Quanto::Client.new(consumer_key, consumer_secret)
    end

    it 'passes consumer credentials' do
      OAuth2::Client.should_receive(:new).with(consumer_key, consumer_secret, anything)
      Quanto::Client.new(consumer_key, consumer_secret)
    end

    it 'passes the quanto URL' do
      OAuth2::Client.should_receive(:new) do |key, secret, options|
        expect(options[:site]).to eq('http://quanto.herokuapp.com')
      end
      Quanto::Client.new(consumer_key, consumer_secret)
    end

  end

  describe '#access_token' do

    let(:client) { double('OAuth2::Client') }
    let(:client) { Quanto::Client.new(consumer_key, consumer_secret, options) }

    context 'without credentials' do

      let(:options) { {} }

      it 'returns nil' do
        expect(client.send(:access_token)).to be_nil
      end

    end

    context 'with credentials' do

      let(:options) { { access_token: 'token' } }

      it 'creates an access token' do
        OAuth2::AccessToken.should_receive(:new)
        client.send(:access_token)
      end

      it 'passes the consumer' do
        OAuth2::AccessToken
          .should_receive(:new)
          .with(anything, options[:access_token])
        client.stub(:client).and_return(double('OAuth2::Client'))
        client.send(:access_token)
      end

    end

  end

end
