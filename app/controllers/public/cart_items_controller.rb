class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
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
    redirect_to cart_items_path
  end

  def destroy_all
    #binding.pry
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

end
