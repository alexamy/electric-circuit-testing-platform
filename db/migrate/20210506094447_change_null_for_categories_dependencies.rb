# frozen_string_literal: true

class ChangeNullForCategoriesDependencies < ActiveRecord::Migration[6.1]
  def change
    change_column_null :static_questions, :question_id, true
    change_column_null :test_attempts, :category_id, true
  end
end
