# frozen_string_literal: true

# changed the datatype for role from string to integer
class ChangeDataTypeOfRoleInUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :role, :string
  end
end
