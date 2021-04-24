# frozen_string_literal: true

class CreateTestAttempts < ActiveRecord::Migration[6.0]
  def change
    create_table :test_attempts do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.belongs_to :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    change_table :static_questions do |t|
      t.belongs_to :test_attempt, null: false, foreign_key: true
    end
  end
end
