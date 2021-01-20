class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def sub_total_price
    item.price * amount
  end
end
