# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    sign_in users(:michael)
  end

  # home page
  test 'should get home' do
    get home_path
    assert_response :success
  end

  # help page
  test 'should get help' do
    get help_path
    assert_response :success
  end

  # about page
  test 'should get about' do
    get about_path
    assert_response :success
  end

  # contact page
  test 'should get contact' do
    get contact_path
    assert_response :success
  end
end
