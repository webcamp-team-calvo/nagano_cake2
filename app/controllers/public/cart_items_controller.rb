class Public::CartItemsController < ApplicationController

  def index
    #binding.pry
    @item = Item.find(params[:item_id])
    CartItem.create(customer_id: current_customer.id, item_id: @item.id, amount: params[:amount])
    @cart_items = CartItem.all
  end

  def update
  end

  def create
  end

  def destroy
  end

  def destroy_all
  end

end
