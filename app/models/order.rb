class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items

    enum status: {
    "入金待ち": 0,
    "入金確認": 1,
    "製作中": 2,
    "配送準備": 3,
    "配送済み": 4
  }
end