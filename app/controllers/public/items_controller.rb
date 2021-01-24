class Public::ItemsController < ApplicationController
  
  def index
    @active_items = Item.where(is_active: true).page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @amount = [1,2,3,4,5,6,7,8,9,10]
  end

end
