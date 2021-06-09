class AddVariantsToParameters < ActiveRecord::Migration[6.1]
  def change
    add_column :parameters, :variants, :string
  end
end
