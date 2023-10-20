class Product < ApplicationRecord
  belongs_to :user

  has_many :orders, dependent: :destroy

  paginates_per 10

  validates :product_type, presence: true
  validates :price, presence: true , numericality: { greater_than: 0 }
  validates :product_name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 3 }

end
