# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :questions do |t|
      t.string :text
      t.string :comment
      t.text :formula_text
      t.json :formula

      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
# rubocop:enable Metrics/MethodLength
