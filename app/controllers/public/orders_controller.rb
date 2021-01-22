class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @deliveries = Delivery.all
  end

  def confirm
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @postage = 800
    @order = Order.new(order_params)
    if params[:c1] == "user_address"
      @order.postcode = current_customer.postcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:c1] == "delivery_address"
      @delivery = Delivery.find(params[:customer_id])
      @order.postcode = @delivery.postcode
      @order.address = @delivery.address
      @order.name = @delivery.name
    else params[:c1] == "new_address"
      @new_delivery = Delivery.new(delivery_params)
      @new_delivery.customer_id = current_customer.id
      if @new_delivery.save
        @order.postcode = @new_delivery.postcode
        @order.address = @new_delivery.address
        @order.name = @new_delivery.name
      end
    end
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
    params.permit(:customer_id, :status, :postage, :total_payment, :payment_method)
  end

  def delivery_params
    params.permit(:postcode, :address, :name)
  end

end
