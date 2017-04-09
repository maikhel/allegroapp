require 'rails_helper'

describe 'SoapClient' do
  it 'exists' do
    expect(SoapClient.new).to be_a SoapClient
  end

  describe 'search' do
    it 'returns hash of results' do
      client = SoapClient.new
      response = client.search 'dude'
      expect(response).to be_a Hash
    end

  end
describe 'login' do

end
end
