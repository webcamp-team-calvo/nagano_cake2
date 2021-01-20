class Delivery < ApplicationRecord
  belongs_to :customer
  
  with_options presence: true do
	  validates :postcode, format: {with: /\A\d{7}\z/}, numericality: true
	  validates :name
	  validates :address
	end
	
end
