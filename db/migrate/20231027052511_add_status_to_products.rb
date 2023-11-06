# frozen_string_literal: true

# new column product_status added in product table
class AddStatusToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :product_status, :string
  end
end
