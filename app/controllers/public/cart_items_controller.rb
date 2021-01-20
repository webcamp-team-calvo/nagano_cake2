class Public::CartItemsController < ApplicationController

  def index
    #@item = Item.find(params[:item_id])
    #@cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: @item.id, amount: params[:amount])
    #session[:cart_item] = @cart_item
    #@cart_items = CartItem.all(session[:cart_item])
    @cart_items = CartItem.all
            #binding.pry
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  def create
    @item = Item.find(params[:item_id])
    @cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: @item.id, amount: params[:amount])
    CartItem.create(customer_id: current_customer.id, item_id: @item.id, amount: params[:amount])
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = CartItem.all
    redirect_to cart_items_path
  end

  def destroy_all
  end

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

end
