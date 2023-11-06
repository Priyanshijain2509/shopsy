# frozen_string_literal: true

# changed contact_numbr datatype from integer to string
class ChangeContactNumberInUser < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :contact_number, :string
  end
end
