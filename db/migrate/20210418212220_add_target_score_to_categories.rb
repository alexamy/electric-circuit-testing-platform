# frozen_string_literal: true

class AddTargetScoreToCategories < ActiveRecord::Migration[6.0]
  def change
    change_table :categories do |t|
      t.integer :target_score, null: false
    end
  end
end
