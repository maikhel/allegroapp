
require 'spec_helper'
require 'soap_client.rb'

describe SoapClient do 

  before(:each) { client = SoapClient.new }

  it 'creates valid Soap Client' do 

  end

  describe 'get_api_version' do 


  end

  describe 'get_categories_version' do 


  end

  describe 'login' do 

  end

  describe 'search' do 


  end


end

# jak aplikacja ma dzialac:
#  - wchodze na strone glowna i widze kategorie i pole do wyszukiwania
#   - wpisuje slowo, zaznaczam kategorie i klikam SZUKAJ i wtedy:
# SoapConnection.new: 

# - tworze klienta Savon
# - pobiera aktualna wersje API 
# - sprawdzam czy mam aktualne kategorie, jak nie to pobieram aktualne kategorie
# - loguje sie
# - szukam
# - 