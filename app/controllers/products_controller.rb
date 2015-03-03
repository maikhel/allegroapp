class ProductsController < ApplicationController
  
  def index

  	client = SoapConnection.new
  	@checked_id = 0
    
  	 if params[:search]
      @data = client.search(params[:search], @checked_id)
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

