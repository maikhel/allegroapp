class ProductsController < ApplicationController
  
  def index
  	p = Lol.new
  	@data = p.data
  	render 'index'
  end

end
