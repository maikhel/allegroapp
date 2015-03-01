class ProductsController < ApplicationController
  
  def index
  	p = Product.new
  	
  	render 'index'
  end

end
