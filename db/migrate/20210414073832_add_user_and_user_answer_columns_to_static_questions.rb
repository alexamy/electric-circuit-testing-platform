# frozen_string_literal: true

class AddUserAndUserAnswerColumnsToStaticQuestions < ActiveRecord::Migration[6.0]
  def change
    change_table :static_questions, bulk: true do |t|
      t.float :user_answer
      t.belongs_to :user, null: false, foreign_key: true
    end
  end
end
