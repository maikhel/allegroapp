class ProductsController < ApplicationController
  
  def index
	client = SoapConnection.new

	client.login
	@data = client.search("auto")

  	render 'index'
  end

end
