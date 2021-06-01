# frozen_string_literal: true

class RenameCategoriesTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :categories, :tests
    rename_column :questions, :category_id, :test_id
    rename_column :test_attempts, :category_id, :test_id
  end
end
