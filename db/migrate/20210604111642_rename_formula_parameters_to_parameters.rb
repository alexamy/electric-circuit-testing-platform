# frozen_string_literal: true

class RenameFormulaParametersToParameters < ActiveRecord::Migration[6.1]
  def change
    rename_table :formula_parameters, :parameters
  end
end
