class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @deliveries = Delivery.all
  end
  
  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @postage = 800
    @order = Order.new
  end
  
  def cretae
  end
  
  def thanks
  end
  
  def index
  end
  
  def show
  end
  
  private
  
  def order_params
    params.require(:order).permit(:customer_id, :status, :postage, :total_payment, :payment_method, :postcode, :address, :name)
  end
  
end
