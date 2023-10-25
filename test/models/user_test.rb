require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      contact_number: '9876540210',
      email: 'user@example.com',
      password: 'password123',
      address: '123 Main St',
      state: 'California',
      pin_code: 123456,
      role: 'seller'
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end
  
  test 'first_name should be present' do
    @user.first_name = ''
    assert_not @user.valid?
  end

  test 'last_name should be present' do
    @user.last_name = ''
    assert_not @user.valid?
  end

  test 'contact_number should be present' do
    @user.contact_number = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = ''
    assert_not @user.valid?
  end

  test 'address should be present' do
    @user.address = ''
    assert_not @user.valid?
  end

  test 'state should be present' do
    @user.state = ''
    assert_not @user.valid?
  end

  test 'pin_code should be present' do
    @user.pin_code = ''
    assert_not @user.valid?
  end

  test 'role should be present' do
    @user.role = ''
    assert_not @user.valid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * 31
    assert_not @user.valid?
  end

  test "first_name should not be too small" do
    @user.first_name = "a" * 2
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 21
    assert_not @user.valid?
  end

  test "last_name should not be too small" do
    @user.last_name = "a" * 2
    assert_not @user.valid?
  end

  test 'contact_number should have exactly 10 digits & in correct format' do
    valid_values = %w[9876543210 8976480953]
    valid_values.each do |contact_number|
      assert_match(/\A[6-9]\d{9}\z/, contact_number, "#{contact_number.inspect} 
      should have exactly 10 digits & in correct format")
    end
  
    invalid_values = %w[1234568098 1234567 ABCDEFGHIJ]
    invalid_values.each do |contact_number|
      refute_match(/\A[6-9]\d{9}\z/, contact_number, "#{contact_number.inspect} 
        should not have less than 10 digits & cannot contain alphabet")
    end

  end

  test 'pin_code should have exactly 6 digits' do
    valid_values = %w[123456 987654]
    valid_values.each do |pin_code|
      assert_match(/\A\d{6}\z/, pin_code, "#{pin_code.inspect} 
        should have exactly 6 digits")
    end

    invalid_values = %w[12345678 98742 ABCDRF]
    invalid_values.each do |pin_code|
      refute_match(/\A\d{6}\z/, pin_code, "#{pin_code.inspect} 
        should have exactly 6 digits & cannot contain alphabet")
    end

  end

end
