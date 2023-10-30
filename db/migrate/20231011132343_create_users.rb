# frozen_string_literal: true

# user table
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :contact_number
      t.string :address
      t.string :state
      t.integer :pin_code

      t.timestamps
    end
  end
end
