class ProductsController < ApplicationController
  
  def index
  	p = Product.new
  	@data = p.data
  	render 'index'
  end

end
