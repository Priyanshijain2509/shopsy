# frozen_string_literal: true

# Controller for handling and manipulating user functionality
class UsersController < ApplicationController
  # to dsiaply all users
  def index
    users = User.all

    render json: users
  end

  def all_users
  end

    # to destroy the user
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      render json: { message: 'User deleted successfully' }, status: :ok
    end
end
