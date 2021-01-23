class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

  enum status: [ :入金待ち, :入金確認, :制作中, :発送準備中, :発送済み ]

end