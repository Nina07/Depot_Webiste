class UsersController < ApplicationController
  before_filter :current_cart

  def index
    @users = User.order(:name)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    respond_to do |format| 
      if @user.errors.empty?
        @user.save        
        format.html { redirect_to users_path }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new"}
        format.json { render json: @user.errors, status: :unprocessable_entry }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render @user }
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to users_url , notice: "User #{@user.name} successfully updated."}
        format.json { render json: @user, status: :updated, location: @user }
      else
        format.html { render action: edit}
        format.json { render json: @user.errors, status: :unprocessable_entry }
      end
    end
  end

  def show
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
        format.html { redirect_to users_url }
        format.json { render json: @user }
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:password, :password_confirmation)
  end
end
