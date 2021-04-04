# frozen_string_literal: true

class AddPrecisionToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :precision, :integer, default: 0, null: false
  end
end
