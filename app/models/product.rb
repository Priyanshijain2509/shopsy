class Product < ApplicationRecord
  belongs_to :user
  validates :product_name, :product_type, :description, :price,  presence: true

end
