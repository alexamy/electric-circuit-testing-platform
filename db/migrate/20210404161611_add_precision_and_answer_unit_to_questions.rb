# frozen_string_literal: true

class AddPrecisionAndAnswerUnitToQuestions < ActiveRecord::Migration[6.0]
  def change
    change_table :questions, bulk: true do |t|
      t.integer :precision
      t.string :answer_unit
    end
  end
end
