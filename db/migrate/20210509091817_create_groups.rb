# frozen_string_literal: true

class CreateGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.integer :year, null: false

      t.timestamps
    end

    change_table :users do |t|
      t.belongs_to :group, foreign_key: true
    end
  end
end
