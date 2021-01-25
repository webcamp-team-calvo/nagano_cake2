class Item < ApplicationRecord
  belongs_to :category
  has_many :order_items
  has_many :cart_items

  attachment :image
  
  def self.search_for(content, method)
    if method == 'forward'
      Item.where('name LIKE ?', content+'%')
    elsif method == 'backward'
      Item.where('name LIKE ?', '%'+content)
    else
      Item.where('name LIKE ?', '%'+content+'%')
    end
  end

end
