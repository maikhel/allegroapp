class ProductsController < ApplicationController
  
  def index

  	client = SoapConnection.new
  	cat = client.categories[params[:category]]
    order = params[:order]
    order == 'price'? order=4 : order=1
  	if params[:search]
      @data = client.search(params[:search], cat,order)
    else
      @data = client.search("auto", 5,1)
    end
  	render 'index'
  end




  

end

