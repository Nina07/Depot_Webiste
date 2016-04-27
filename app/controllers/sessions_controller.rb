class SessionsController < ApplicationController
  skip_before_filter :authorize
  before_filter :current_cart

  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_index_url
    else
      render text: "Invalid login"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to store_url, notice: "Logged out"
  end
end
