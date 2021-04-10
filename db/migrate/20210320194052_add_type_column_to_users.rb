# frozen_string_literal: true

class AddTypeColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :type, :string, default: "User", null: false
    add_index :users, :type
  end
end
