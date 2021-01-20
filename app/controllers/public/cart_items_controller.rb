class Public::CartItemsController < ApplicationController

  def index
    @item = Item.find(params[:item_id])
    #@cart_item = CartItem.find_by(customer_id: current_customer.id, item_id: @item.id, amount: params[:amount])
    CartItem.create(customer_id: current_customer.id, item_id: @item.id, amount: params[:amount])
    @cart_items = CartItem.all
            #binding.pry
  end

  def update
  end

  def create
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    @cart_items = CartItem.all
    # redirect_to request.refererにするとindexでのcreateが実行されアイテムが増えてしまった。
    render 'index'
  end

  def destroy_all
  end

end
