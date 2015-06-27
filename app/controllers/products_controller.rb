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

  	client = SoapConnection.new
    @categories = client.categories
  	cat = client.categories[params[:category]]
    order = params[:order]
    order == 'price'? order=4 : order=1
    @items = []
    @items = client.search(params[:search], cat,order) if params[:search]
   
  	render 'index'
  end

private

  def product_params
    params.require(:product).permit(:name, :price, :ending_time, :thumb_url, :link, :allegro_id
)
  end


end

