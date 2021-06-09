class AddFormulaFieldToParameters < ActiveRecord::Migration[6.1]
  def change
    add_column :parameters, :formula, :string
  end
end
