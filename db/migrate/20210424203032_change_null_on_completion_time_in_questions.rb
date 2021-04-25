# frozen_string_literal: true

class ChangeNullOnCompletionTimeInQuestions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :questions, :completion_time, false
  end
end
