# frozen_string_literal: true

class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name

      t.timestamps
    end

    create_table :questions do |t|
      t.string :formula_text
      t.string :text
      t.string :comment
      t.json :formula

      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
