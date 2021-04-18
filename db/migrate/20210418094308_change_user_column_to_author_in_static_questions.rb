# frozen_string_literal: true

class ChangeUserColumnToAuthorInStaticQuestions < ActiveRecord::Migration[6.0]
  def change
    rename_column :static_questions, :user_id, :author_id
  end
end
