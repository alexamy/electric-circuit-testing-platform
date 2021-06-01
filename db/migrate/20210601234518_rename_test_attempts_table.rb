# frozen_string_literal: true

class RenameTestAttemptsTable < ActiveRecord::Migration[6.1]
  def change
    rename_table :test_attempts, :attempts
    rename_column :static_questions, :test_attempt_id, :attempt_id
  end
end
