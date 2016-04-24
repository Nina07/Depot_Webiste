class CartsController < ApplicationController

  def index
    @carts = Cart.all
  end

  def show
  	begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: 'Invalid Cart'
    else
      respond_to do |format|
        format.html 
        format.json {render json: @cart}
      end
    end
  end

  def destroy
    @cart = current_cart
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :no_content }
    end
  end

end
