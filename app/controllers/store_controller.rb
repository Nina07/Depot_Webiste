class StoreController < ApplicationController
  def index    
    @page_title = "Book"
    @products = Product.order(:title)
  end
end
