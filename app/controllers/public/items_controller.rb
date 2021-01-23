class Public::ItemsController < ApplicationController
  
  # before_action :authenticate_customer!,except: [:index, :show]
   
  def index
    @active_items = Item.where(is_active: true).page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
  end

end
