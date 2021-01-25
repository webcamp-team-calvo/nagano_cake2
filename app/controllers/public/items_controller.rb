class Public::ItemsController < ApplicationController

  def index
    @active_items = Item.where(is_active: true).page(params[:page])
  end

  def show
    #@item = Item.find(params[:id])
    #@amounts_array = ["個数選択", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
    #@first_choice_array = "個数選択".to_i
    @item = Item.find(params[:id])
    @cart_item = CartItem.new

  end

end
