# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @devise_user = users(:joy)
  end

  test 'should get new registration page' do
    get new_user_registration_path
    assert_response :success
  end

  test 'should redirect index when not logged in' do
    get users_path
    assert_redirected_to new_user_session_path
  end

  test 'should redirect edit when not logged in' do
    get edit_user_registration_path(@user)
    assert_response :unauthorized
  end

  test 'should redirect update when not logged in' do
    patch user_registration_path(@user), params: { user: {
      first_name: @user.first_name, last_name: @user.last_name,
      contact_number: @user.contact_number, address: @user.address,
      state: @user.state, pin_code: @user.pin_code,
      email: @user.email
    } }
    assert_response :unauthorized
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'User.count' do
      delete user_registration_path(@user)
    end
    assert_response :unauthorized
  end

  test 'should redirect destroy when logged in as a non-admin' do
    sign_in users(:archer)
    assert_difference 'User.count', -1 do
      delete user_registration_path
    end
    assert_redirected_to root_path
  end

  test 'should create a new user' do
    assert_difference('User.count') do
      post user_registration_path, params: { user: {
        first_name: 'Raman',
        last_name: 'Mishra',
        email: 'raman@co.in',
        password: 'password',
        password_confirmation: 'password',
        role: 'seller',
        contact_number: '9634511021',
        address: 'Kota',
        state: 'Rajasthan',
        pin_code: 321450
      } }
    end
    assert_redirected_to root_path
  end

  test 'should not create a user with invalid data' do
    assert_no_difference('User.count') do
      post user_registration_path, params: { user: { email: 'invalid-email', password: 'short' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should not update the profile with invalid data' do
    sign_in users(:michael)
    patch user_registration_path, params: { user: { email: 'invalid-email', current_password: 'password123' } }
    assert_response :unprocessable_entity
  end

  test 'user should be confirmed upon confirmation' do
    @user.confirm
    assert @user.confirmed?
  end

  test 'user should not be confirmed without confirmation' do
    assert_not @devise_user.confirmed?
  end
end
