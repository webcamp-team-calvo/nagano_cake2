class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
  end

  def thanks
  end

  def index
  end

  def show
  end

end
