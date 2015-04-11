class ProductsController < ApplicationController
  

  def create
    @item = Item.new(product_params)

    # flash[:success] = 'Product successfully saved' if @item.save

    respond_to do |format|
      if @item.save
        format.js {render :create, notice: 'Product kkkkk'}
      end
    end

  end

  def index

  	client = SoapConnection.new
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

