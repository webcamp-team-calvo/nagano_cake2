class Admin::OrdersController < ApplicationController
  
  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:item)
    @total_price = @order_items.sum{|order_item|(order_item.price * 1.1).round * order_item.amount }
  end
  
  def update
    @order = Order.find(params[:id])
    @order_items = @order.order_items
    @order.update(order_params)
    if @order.status == "入金待ち"
       @order_items.update_all(making_status: 0)
    elsif @order.status == "入金確認"
      @order_items.update_all(making_status: 1)
    end
    redirect_to admins_order_item_path(@order)
  end
end
