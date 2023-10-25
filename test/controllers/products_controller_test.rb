require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  def setup
    @product = products(:watch)
  end

  test 'should redirect create when not logged in' do
    user = users(:michael)
    sign_out user
    assert_no_difference 'Product.count' do
      post user_products_path(user), params: { product: {
        product_name: "watch", 
        product_type: "Electronic",
        description: "A wrist watch",
        price: 5999
        } }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy when not logged in' do
    user = users(:michael)
    sign_out user
    assert_no_difference 'Product.count' do
      delete user_product_path(user, @product)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should redirect destroy for wrong micropost' do
    user = users(:michael)
    product = products(:phone)   
    assert_no_difference 'Product.count' do
      delete user_product_path(user, product)
    end
    assert_redirected_to new_user_session_path
  end

  test 'should create a product for correct user' do
    user = users(:michael)
    sign_in user
    assert_difference 'Product.count', 1 do
      post user_products_path(user), params: { product: {
        product_name: 'Wall watch',
        product_type: 'Electronic',
        description: 'A Wall watch',
        price: 1999
      } }
    end
  end

end
