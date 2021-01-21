class Public::OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def confirm
    
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
