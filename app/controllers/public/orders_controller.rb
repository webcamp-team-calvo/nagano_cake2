class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def create
    #binding.pry
    @order = Order.new(order_params)
    #binding.pry
    @order.save
    redirect_to orders_confirm_path
  end

  def thanks
  end

  def index
  end

  def show
  end

  def order_params
    params.require(:order).permit(:customer_id, :payment_method, :postcode, :address, :name)
  end

end
