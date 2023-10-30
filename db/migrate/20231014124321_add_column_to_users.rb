# frozen_string_literal: true

# resolved the confrim mail issue of devise gem
class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :confirmation_token, :string
    add_column :users, :unconfirmed_email, :string
    add_column :users, :confirmation_sent_at, :datetime
  end
end
