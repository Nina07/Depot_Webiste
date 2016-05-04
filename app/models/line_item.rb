class LineItem < ActiveRecord::Base
  belongs_to :order, touch: true
	belongs_to :cart
	belongs_to :product
  
	def total_price
		product.price * quantity
	end
end
