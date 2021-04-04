# frozen_string_literal: true

class CreateStaticQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :static_questions do |t|
      t.json :arguments
      t.belongs_to :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
