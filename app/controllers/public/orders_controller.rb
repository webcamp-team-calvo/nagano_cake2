class Public::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:product)
    @total_price = @order_items.sum{|order_item|(order_item.order_price * 1.1).floor * order_item.quantity  }
  end

  def new
    @customer = current_customer
    @order = Order.new
  end

  def thanks
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
      current_customer.cart_items.each do |cart_item|
        @order_item = @order.order_items.new
        @order_item.order_id = @order.id
        @order_item.product_id = cart_item.product_id
        @order_item.quantity = cart_item.quantity
        @order_item.order_price = cart_item.product.price
        @order_item.save
      end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
    @orders = current_customer.orders.includes(order_items: :product)
  end

  def confirm
   
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :total_payment, :payment_method,
     :postcode, :postage, :address, :status, order_items_attributes:
      [:order_id, :item_id, :amount, :price, :making_status])
  end

end