# frozen_string_literal: true

require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @order = orders(:one)
  end

  # test for placing order
  test 'should create an order' do
    user = users(:johnson)
    product = products(:watch)
    sign_in user
    assert_difference 'Order.count', 1 do
      post user_product_orders_path(user, product, format: :js), params: { order: {
        buyer: user.id,
        seller: product.user_id,
        product_id: product.id,
        status: 'Placed'
      } }
    end
    assert_response :success
    assert_equal 'Order placed successfully', flash[:success]
    assert_equal "You'll recieve a order confirmation mail!", flash[:info]
    assert_equal 1, ActionMailer::Base.deliveries.size
    last_email = ActionMailer::Base.deliveries.last
    assert_equal [user.email], last_email.to
    assert_equal 'Order Confirmation', last_email.subject
  end

  # test for cancelling order
  test 'should cancel an order' do
    user = users(:michael)
    product = products(:watch)
    sign_in user
    patch user_product_order_path(user, product, @order, format: :js)
    assert_response :success
    assert_equal 'Order cancelled', flash[:success]
    assert_equal "You'll recieve a order cancellation mail!", flash[:info]
    assert_equal 1, ActionMailer::Base.deliveries.size
    last_email = ActionMailer::Base.deliveries.last
    assert_equal [user.email], last_email.to
    assert_equal 'Order Cancellation', last_email.subject
  end
end
