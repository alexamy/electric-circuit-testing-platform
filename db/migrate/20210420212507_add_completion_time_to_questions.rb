# frozen_string_literal: true

class AddCompletionTimeToQuestions < ActiveRecord::Migration[6.0]
  def change
    change_table :questions do |t|
      t.integer :completion_time
    end
  end
end
