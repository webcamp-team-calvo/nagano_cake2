class Item < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items
  
  attachment :image
  
  enum is_active:{
    販売中: 0,
    販売停止中: 1
  }
end
