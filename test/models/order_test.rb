# frozen_string_literal: true

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # default method
  def setup
    @order = orders(:two)
  end

  # order details should contain all necessary deatils
  test 'should be valid' do
    assert @order.valid?
  end

  # buyer should be present
  test 'org_buyer should be present' do
    @order.org_buyer = nil
    assert_not @order.valid?
  end

  # seller should be present
  test 'org_seller should be present' do
    @order.org_seller = nil
    assert_not @order.valid?
  end

  # product id should be present
  test 'product id should be present' do
    @order.product_id = nil
    assert_not @order.valid?
  end

  # status should be present
  test 'status should be present' do
    @order.status = nil
    assert_not @order.valid?
  end

  # status should only allow 'Placed' or 'Cancelled'
  test 'status should only allow "Placed" or "Cancelled" ' do
    valid_statuses = %w[Placed Cancelled]
    valid_statuses.each do |status|
      @order.status = status
      assert @order.valid?, "#{status.inspect} should be a valid status"
    end

    invalid_statuses = %w[Shipped Processing Delivered]
    invalid_statuses.each do |status|
      @order.status = status
      assert_not @order.valid?, "#{status.inspect} should be an invalid status"
    end
  end
end
