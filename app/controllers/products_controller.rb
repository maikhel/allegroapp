class ProductsController < ApplicationController

  before_action :authenticate_user!

  def create
    @item = Item.new(product_params)
    @id = product_params[:allegro_id]
    # flash[:success] = 'Product successfully saved' if @item.save

    respond_to do |format|
      if @item.save
        format.js {render :create}
      end
    end

  end

  def index


    @categories = {"Elektronika" => 10, "Moda i uroda" => 250152, "Dom i zdrowie" =>79197,
    "Dziecko" => 250145, "Kultura i rozrywka" => 262, "Sport i wypoczynek" => 3919,
    "Motoryzacja" => 3, "Kolekcje i sztuka" => 105417, "Firma i usługi" => 105414,
    "Strefa okazji"=>98316, "Wszystko" => 0}
    @items = []

  end

  def search

  	client = SoapClient.new
  	cat = client.categories[params[:category]]
    order = params[:order]
    order == 'price'? order=4 : order=1

    @items = client.search(params[:search], cat,order) if params[:search]

  end


private

  def product_params
    params.require(:product).permit(:name, :price, :ending_time, :thumb_url, :link, :allegro_id
)
  end


end

