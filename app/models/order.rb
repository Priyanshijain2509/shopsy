class Order < ApplicationRecord
  belongs_to :org_buyer, class_name: 'User', foreign_key: 'buyer'
  belongs_to :org_seller, class_name: 'User', foreign_key: 'seller'
  belongs_to :product

  validates :status, inclusion: { in: ['Ordered', 'Cancelled'] }
end
