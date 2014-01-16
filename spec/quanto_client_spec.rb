require 'spec_helper'
require 'oauth'

describe Quanto::Client do

  let(:consumer_key) { 'consumer_key' }
  let(:consumer_secret) { 'consumer_secret' }

  describe '#initialize' do

    it 'constructs an OAuth consumer' do
      OAuth::Consumer.should_receive(:new)
      Quanto::Client.new(consumer_key, consumer_secret)
    end

    it 'passes consumer credentials' do
      OAuth::Consumer.should_receive(:new).with(consumer_key, consumer_secret, anything)
      Quanto::Client.new(consumer_key, consumer_secret)
    end

    it 'passes the quanto URL' do
      OAuth::Consumer.should_receive(:new) do |key, secret, options|
        expect(options[:site]).to eq('http://quanto.herokuapp.com')
      end
      Quanto::Client.new(consumer_key, consumer_secret)
    end

  end

  describe '#access_token' do

    let(:consumer) { double('OAuth::Consumer') }
    let(:client) { Quanto::Client.new(consumer_key, consumer_secret, options) }

    context 'without credentials' do

      let(:options) { {} }

      it 'returns nil' do
        expect(client.send(:access_token)).to be_nil
      end

    end

    context 'with credentials' do

      let(:options) { { access_token: 'token', access_token_secret: 'secret' } }

      it 'creates an access token' do
        OAuth::AccessToken.should_receive(:new)
        client.send(:access_token)
      end

      it 'passes the consumer' do
        OAuth::AccessToken.should_receive(:new).with(anything, options[:access_token], options[:access_token_secret])
        client.stub(:consumer).and_return(double('OAuth::Consumer'))
        client.send(:access_token)
      end

    end

  end

end
