# frozen_string_literal: true

class RenameStaticQuestionsToTasks < ActiveRecord::Migration[6.1]
  def change
    rename_table :static_questions, :tasks
  end
end
