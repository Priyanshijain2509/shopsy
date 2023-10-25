require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:watch)
  end

  test 'should be valid' do
    assert @product.valid?
  end

  test 'product_name should be present' do
    @product.product_name = ''
    assert_not @product.valid?
  end

  test 'product_type should be present' do
    @product.product_type = ''
    assert_not @product.valid?
  end

  test 'description should be present' do
    @product.description = ''
    assert_not @product.valid?
  end
  
  test 'price should be present' do
    @product.price = ''
    assert_not @product.valid?
  end

  test "product_name should not be too small" do
    @product.product_name = "a" * 2
    assert_not @product.valid?
  end

  test "description should not be too small" do
    @product.description = "a" * 2
    assert_not @product.valid?
  end

  test "user id should be present" do
    @product.user_id = nil
    assert_not @product.valid?
  end
end
