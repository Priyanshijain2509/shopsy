# frozen_string_literal: true

# Controller for handling and manipulating user functionality
class UsersController < ApplicationController
  # to dsiaply all users
  def index
    @users = User.page params[:page]
  end
end
