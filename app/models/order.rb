class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  enum payment_method: { クレジットカード: 1, 銀行振込: 2 }

end
