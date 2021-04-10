# frozen_string_literal: true

class CreateFormulaParameters < ActiveRecord::Migration[6.0]
  def change
    create_table :formula_parameters do |t|
      t.string :name
      t.integer :minimum
      t.integer :maximum
      t.integer :step
      t.string :unit
      t.belongs_to :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
