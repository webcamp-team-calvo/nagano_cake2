class Item < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items

  attachment :image

 with_options presence: true do
    validates :image_id
    validates :category_id
    validates :name, length: {maximum: 20, minimum: 1}
    validates :information
    validates :price, numericality: true
  end

end
