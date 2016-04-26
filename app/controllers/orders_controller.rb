class OrdersController < ApplicationController
  skip_before_filter :authorize, only: [:new, :create]

  before_filter :current_cart
  
  def index
    @orders = Order.paginate(page: params[:page], per_page: 5)
                            .order('created_at desc')
    respond_to do |format|
      format.html 
      format.json { render json: @orders}
    end
  end

  def edit
    @order = Order.find(params[:id])
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.js { @current_order = @order.id }
      end
  end

  def new
    @cart = current_cart
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your Cart is Empty. Please choose Items first and then proceed to checkout."
      return
    end
    @order = Order.new
    respond_to do |format|
      format.html
      format.json { render json: @order}
    end
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(current_cart)
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        OrderNotifier.received(@order).deliver
        session[:cart_id] = nil
        format.html { redirect_to store_url, notice: 'Thank you for your Order'}
        format.json { render json: @order, status: :created, location: @order}
      else
        @cart = current_cart
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path }
      format.js { @current_order = @order.id }
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Product was successfully updated.' }
        format.js { @updated_order = @order.id }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
