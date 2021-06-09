class AddParameterType < ActiveRecord::Migration[6.1]
  def change
    add_column :parameters, :type, :string, default: 'StepParameter', null: false
    add_index :parameters, :type
  end
end
