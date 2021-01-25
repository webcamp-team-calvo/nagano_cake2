class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = CartItem.where(customer_id: current_customer.id)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def create
    @customer = current_customer
    @cart_item = @customer.cart_items.new(cart_item_params)
    @now_cart_item = @customer.cart_items.find_by(item_id: @cart_item.item_id)
    #ここで比較するための二つのカートを作成する。
    #"新しいカートの状態のカート"と、"すでに存在している状態のカート"。
    #@cart_item = CartItem.new(customer_id: current_customer.id, item_id: params[:item_id], amount: params[:amount])
    #@cart_items = CartItem.where(customer_id: current_customer.id)
    #@cart_items.each do |cart_item|
     # if cart_item.item_id == @cart_item.item_id
      #  total_amount = cart_item.amount + @cart_item.amount
       # cart_item.update_attribute(:amount, total_amount)
        #@cart_item.delete
      #end
    #end
    #@cart_item.save
    #redirect_to cart_items_path
     if @now_cart_item && @cart_item.amount.to_i >= 1
       # => は〜より大きいか等しい、という比較演算子
       #この場合は、カートアイテム内の数量（amount.to_i）が１より大きいか等しい場合
       @now_cart_item.amount += @cart_item.amount
       @now_cart_item.update(amount: @now_cart_item.amount)
       redirect_to cart_items_path
       #こっちはupdateに成功した場合のリダイレクト
     else
        if @cart_item.save
        redirect_to cart_items_path
        #こっちはcreateに成功した場合のリダイレクト
        else
         flash[:alert] = "カートに入れる個数を入力してください"
         redirect_back(fallback_location: cart_items_path)
        end
      #今回の場合は、三つの条件分岐を作る。
      #１すでにカートに入っている状態の商品の数量がアップデートされた時
      #２まだカートに商品が存在していない状態で新しくCreateされた時
      #３個数選択してくださいのセレクトを選んでカートに入れるを押した時
     end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  def cart_item_params
    #binding.pry
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end

end
