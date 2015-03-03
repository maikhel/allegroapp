class ProductsController < ApplicationController
  
  def index

  	client = SoapConnection.new
  	client.login
  	 if params[:search]
      @data = client.search(params[:search])
    else
      @data = client.search("auto")
    end
  	render 'index'
  end

  

end
