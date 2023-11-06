# frozen_string_literal: true

# order model file
class Order < ApplicationRecord
  # associations
  belongs_to :org_buyer, class_name: 'User', foreign_key: 'buyer'
  belongs_to :org_seller, class_name: 'User', foreign_key: 'seller'
  belongs_to :product

  # validations
  validates :status, presence: true, inclusion: { in: %w[Placed Cancelled] }
  validates :buyer, presence: true
  validates :seller, presence: true
  validates :product_id, presence: true
end
