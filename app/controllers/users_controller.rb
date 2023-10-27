# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show; end

  def index; end
  
  def all_product
    @users = User.where(role: 'seller').page params[:page]
  end

  def create
    @user = User.new(user_params)
    @user.role = User.roles[params[:user][:role]]
    if @user.save
      redirect_to root_path, notice: 'User created successfully!'
    else
      render :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to request.referrer
  end

  def all_user
    @users = User.page params[:page]
  end
  
  def my_order
    @orders = current_user.orders.page params[:page]
  end

  def order_list
    @products = current_user.products.page params[:page]
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :role,
      :contact_number,
      :address,
      :state,
      :pin_code
    )
  end
end
