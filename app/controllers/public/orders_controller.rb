class Public::OrdersController < ApplicationController

  def show
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
    #binding.pry
    redirect_to orders_thanks_path
  end

  def index
  end

  def confirm
    @customer = current_customer
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    # 自身の住所
    if params[:order][:select_address] == "customer_address"
      @order.postcode = @customer.postcode
      @order.address = @customer.address
      @order.name = @customer.last_name + @customer.first_name
    # 登録済住所
    elsif params[:order][:select_address] == "deliverey_address"
      @address = Delivery.find(params[:select_delivery][:id])
      @order.postcode = @address.postcode
      @order.address = @address.address
      @order.name = @address.name
    # 新しいお届け先
    elsif params[:order][:select_address] == "new_deliverey_address"
      @address = Delivery.new
      @address.postcode = params[:order][:new_postcode]
      @address.address = params[:order][:new_address]
      @address.name = params[:order][:new_name]
      @address.customer_id = current_customer.id
      if @address.save
        @order.postcode = @address.postcode
        @order.address = @address.address
        @order.name = @address.name
      else
        render "new"
      end
    end
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :total_payment, :payment_method,
     :postcode, :postage, :address, :status, order_items_attributes:
      [:order_id, :item_id, :amount, :price, :making_status])
  end
end