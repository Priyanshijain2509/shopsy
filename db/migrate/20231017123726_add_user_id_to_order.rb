# frozen_string_literal: true

# added buyer and seller as foreign key in order table
class AddUserIdToOrder < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :orders, :users, column: :seller
    add_foreign_key :orders, :users, column: :buyer
  end
end
