# frozen_string_literal: true

# Controller for handling and manipulating user functionality
class UsersController < ApplicationController
  # to dsiaply all users
  def index
    users = User.all

    render json: users
  end

  # action to handle api from react
  def all_users; end

  # to destroy the user
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    render json: { message: 'User deleted successfully' }, status: :created
  end
end
