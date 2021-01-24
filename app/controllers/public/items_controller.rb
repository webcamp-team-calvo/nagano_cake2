class Public::ItemsController < ApplicationController

  def index
    @active_items = Item.where(is_active: true).page(params[:page])
  end

  def show
    @item = Item.find(params[:id])

    @amounts_array = ["個数選択", "1", "2", "3"]
    #@first_choice_array = "個数選択".to_i

  end

end
