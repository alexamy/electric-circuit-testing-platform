# frozen_string_literal: true

class AddNamesToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
    end
  end
end
