class Order < ApplicationRecord
  belongs_to :org_buyer, class_name: 'User', foreign_key: 'buyer'
  belongs_to :org_seller, class_name: 'User', foreign_key: 'seller'
  belongs_to :product

  validates :status, presence: true, inclusion: { in: ['Ordered', 'Cancelled'] }
  validates :buyer, presence: true
  validates :seller, presence: true
  validates :product_id, presence: true
end
