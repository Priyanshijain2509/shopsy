# frozen_string_literal: true

User.create!([{
               first_name: 'Admin', last_name: 'User',
               contact_number: '9876543210', address: 'Jaipur',
               state: 'Rajasthan', pin_code: 302_019,
               email: 'admin@example.com', password: 'password',
               admin: true, role: 'admin',
               confirmed_at: Time.zone.now
             }])

states = %w[Assam Bihar Goa Gujarat Haryana Karnataka Kerla
            Maharastra Punjab Rajasthan UttarPradesh]

10.times do |n|
  email = "buyer-#{n + 1}@co.in"
  User.create!([{
                 first_name: Faker::Name.first_name,
                 last_name: Faker::Name.last_name,
                 contact_number: "8#{Faker::Number.number(digits: 9)}",
                 address: Faker::Address.street_address,
                 state: states.sample,
                 pin_code: Faker::Number.number(digits: 6),
                 email: email,
                 password: '123456',
                 role: 'buyer',
                 confirmed_at: Time.zone.now
               }])
end

product_types = ['Clothes', 'Electronic', 'Health Care', 'Home Decor', 'Grocery']
product_status = %w[Active Archived]
20.times do |n|
  email = "seller-#{n + 1}@co.in"
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    contact_number: "7#{Faker::Number.number(digits: 9)}",
    address: Faker::Address.street_address,
    state: Faker::Address.state,
    pin_code: Faker::Number.number(digits: 6),
    email: email,
    password: '123456',
    role: 'seller',
    confirmed_at: Time.zone.now
  )

  15.times do
    product = Product.create!(
      product_name: Faker::Commerce.product_name,
      product_type: product_types.sample,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 10.0..1000.0, as_string: false),
      product_status: product_status.sample,
      user: user
    )
  end
end

50.times do
  buyer = User.where(role: 'buyer').sample
  product = Product.all.sample

  Order.create(
    buyer: buyer.id,
    seller: product.user.id,
    product_id: product.id,
    status: %w[Ordered Cancelled].sample
  )
end
