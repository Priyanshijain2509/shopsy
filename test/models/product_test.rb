# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # default method
  def setup
    @product = products(:watch)
  end

  # product should be valid
  test 'should be valid' do
    assert @product.valid?
  end

  # product name should be present
  test 'product_name should be present' do
    @product.product_name = ''
    assert_not @product.valid?
  end

  # product type should be present
  test 'product_type should be present' do
    @product.product_type = ''
    assert_not @product.valid?
  end

  # product description should be present
  test 'description should be present' do
    @product.description = ''
    assert_not @product.valid?
  end

  # product price should be present
  test 'price should be present' do
    @product.price = ''
    assert_not @product.valid?
  end

  # name should not be too small
  test 'product_name should not be too small' do
    @product.product_name = 'a' * 2
    assert_not @product.valid?
  end

  # description should not be too small
  test 'description should not be too small' do
    @product.description = 'a' * 2
    assert_not @product.valid?
  end

  # user id should be present
  test 'user id should be present' do
    @product.user_id = nil
    assert_not @product.valid?
  end
end
