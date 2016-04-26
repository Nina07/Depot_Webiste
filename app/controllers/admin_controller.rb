class AdminController < ApplicationController
  before_filter :current_cart
  
  def index
    @total_orders = Order.count
  end
end
