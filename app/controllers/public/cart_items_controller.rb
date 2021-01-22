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
    #@item = Item.find(params[:item_id])
    #CartItem.create(customer_id: current_customer.id, item_id: params[:item_id], amount: params[:amount])
    @cart_item = CartItem.new(customer_id: current_customer.id, item_id: params[:item_id], amount: params[:amount])
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @cart_items.each do |cart_item|
      if cart_item.item_id == @cart_item.item_id
        total_amount = cart_item.amount + @cart_item.amount
        cart_item.update_attribute(:amount, total_amount)
        #binding.pry
        @cart_item.delete
       #@cart_item.create
      end
    end
    #binding.pry
    @cart_item.save

    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def cart_item_params
    params.require(:cart_item).permit(:amount)
  end

end
