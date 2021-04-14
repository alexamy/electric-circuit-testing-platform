class ChangeColumnNullForAuthorColumnInQuestions < ActiveRecord::Migration[6.0]
  def change
    change_column_null :questions, :author_id, false
  end
end
