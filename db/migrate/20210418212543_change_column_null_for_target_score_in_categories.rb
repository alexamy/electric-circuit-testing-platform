# frozen_string_literal: true

class ChangeColumnNullForTargetScoreInCategories < ActiveRecord::Migration[6.0]
  def change
    change_column_null :categories, :target_score, false
  end
end
