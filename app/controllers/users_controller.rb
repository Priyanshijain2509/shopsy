# frozen_string_literal: true

# Controller for handling and manipulating user functionality
class UsersController < ApplicationController
  # creating new user
  def new
    @user = User.new
  end

  # for creating new user
  def create
    @user = User.new(user_params)
    @user.role = User.roles[params[:user][:role]]
    if @user.save
      redirect_to root_path, notice: 'User created successfully!'
    else
      render :new
    end
  end

  # for destroying existing user
  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = 'User deleted'
    redirect_to request.referrer
  end

  # to dsiaply all users
  def index
    @users = User.page params[:page]
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name, :last_name, :email, :password, :password_confirmation,
      :role, :contact_number, :address, :state, :pin_code
    )
  end
end
