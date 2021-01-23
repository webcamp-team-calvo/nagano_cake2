class Admin::HomesController < ApplicationController

  def top
    @orders = Order.where(customer_id: params[:customer_id])
  end


end
