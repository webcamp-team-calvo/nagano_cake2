class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_many :deliveries
  has_many :cart_items, dependent: :destroy

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def full_name
    last_name + first_name
  end

  def self.search_for(content, method)
    if method == 'forward'
      Customer.where('last_name LIKE ? OR first_name LIKE ?', content + '%',content + '%')
    elsif method == 'backward'
      Customer.where('last_name LIKE ? OR first_name LIKE ?', '%' + content,'%' + content)
    else
      Customer.where('last_name LIKE ? OR first_name LIKE ?', '%' + content + '%','%' + content + '%')
    end
  end

end
