class ProductsController < ApplicationController
  
  def index
	client = SoapConnection.new

	@data = client.take_categories
  	render 'index'
  end

end
