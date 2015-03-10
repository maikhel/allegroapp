class ProductsController < ApplicationController
  
  def index

  	client = SoapConnection.new
  	cat = client.categories[params[:category]]
    order = params[:order]
    order == 'price'? order=4 : order=1
    @data = []
    @data = client.search(params[:search], cat,order) if params[:search]
   
  	render 'index'
  end




  

end

