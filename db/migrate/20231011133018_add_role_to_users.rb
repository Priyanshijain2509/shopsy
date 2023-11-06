# frozen_string_literal: true

# Added a new column role to user table
class AddRoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :role, :integer
  end
end
