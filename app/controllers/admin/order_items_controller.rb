class Admin::OrderItemsController < ApplicationController
  
  def update
    @order_item = OrderItem.find(params[:id])
    @order = @order_item.order
    @order_item.update(order_item_params)
    if @order_item.making_status == "製作中"
       @order.update(status: 2)
    else
      if @order.order_items.where(making_status: 3).count == @order.order_items.count
         @order.update(status: 3)
      end
    end
    redirect_to admins_order_item_path(@order)
  end

  protected
  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
  
end
