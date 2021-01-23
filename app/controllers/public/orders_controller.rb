class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

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
        @order_item.item_id = cart_item.item_id
        @order_item.amount = cart_item.amount
        @order_item.price = cart_item.item.price * 1.1
        @order_item.save
      end
    current_customer.cart_items.destroy_all
    redirect_to orders_thanks_path
  end

  def index
  end

  def confirm
    @customer = current_customer
    @cart_items = current_customer.cart_items
    #binding.pry
    @order = Order.new(order_params)
    # 自身の住所
    if params[:order][:select_address] == "customer_address"
      @order.postcode = @customer.postcode
      @order.address = @customer.address
      @order.name = @customer.last_name + @customer.first_name
    # 登録済住所
    elsif params[:order][:select_address] == "deliverey_address"
      @delivery = Delivery.find(params[:select_delivery][:id])
      @order.postcode = @delivery.postcode
      @order.address = @delivery.address
      @order.name = @delivery.name
    # 新しいお届け先
    elsif params[:order][:select_address] == "new_deliverey_address"
      @delivery = Delivery.new
      @delivery.postcode = params[:order][:new_postcode]
      @delivery.address = params[:order][:new_address]
      @delivery.name = params[:order][:new_name]
      @delivery.customer_id = current_customer.id
      if @delivery.save
        @order.postcode = @delivery.postcode
        @order.address = @delivery.address
        @order.name = @delivery.name
      else
        render "new"
      end
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :name, :total_payment, :payment_method,
     :postcode, :postage, :address, :status)
  end

end