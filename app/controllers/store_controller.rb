class StoreController < ApplicationController
  def index    
    @page_title = "Book"
    @products = Product.order(:title)
    @cart = current_cart
  end
end
