class CartsController < ApplicationController
  skip_before_filter :authorize, only: [:create, :update, :destroy]
  
  def index
    byebug
    @carts = Cart.all
  end

  def show
  	begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid Cart'
    else
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url }
    end
  end

end
