class StoreController < ApplicationController
  before_filter :current_cart

  def index    
    @page_title = "Book"
    @products = Product.order(:title)
    @cart = current_cart
  end
end
