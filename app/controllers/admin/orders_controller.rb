class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all.page(params[:page]).per(10)
  end
end
