require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = orders(:two)
  end

  test 'should be valid' do
    assert @order.valid?
  end

  test 'org_buyer should be present' do
    @order.org_buyer = nil
    assert_not @order.valid?
  end

  test 'org_seller should be present' do
    @order.org_seller = nil
    assert_not @order.valid?
  end

  test "product id should be present" do
    @order.product_id = nil
    assert_not @order.valid?
  end

  test 'status should be present' do
    @order.status = nil
    assert_not @order.valid?
  end

  test 'status should only allow "Ordered" or "Cancelled" ' do
    valid_statuses = %w[Placed Cancelled ]
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
