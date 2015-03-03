class ProductsController < ApplicationController
  
  def index

  	client = SoapConnection.new
  	cat = client.categories[params[:category]]
  	 if params[:search]
      @data = client.search(params[:search], cat)
    else
      @data = client.search("auto", 5)
    end
  	render 'index'
  end

  

end

#TODO
# szukanie po kategoriach
# poprawne id kategorii
# guzik sortowania po cenie
# wyświetlanie linków do ofert

