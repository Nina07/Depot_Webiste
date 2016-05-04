class LineItemsController < ApplicationController
	skip_before_filter :authorize, only: :create
	
	def create
		byebug
		find_cart
		product = Product.find(params[:product_id])
		@line_item = @cart.add_product(product.id)
		@line_item.product = product
		respond_to do |format|
			if @line_item.save
				format.html {redirect_to store_url}
				format.js {@current_item = @line_item}
			else
				format.html {render action: "new"}
			end
		end
	end

	def show
		find_cart
	end

	def destroy
		@line_item = item.id
		respond_to do |format|
	      format.html { redirect_to store_url, notice: 'Your Item has been deleted.'}
    	end
	end

	private

	def find_cart
		@cart = Cart.find(current_cart)
	end

end

