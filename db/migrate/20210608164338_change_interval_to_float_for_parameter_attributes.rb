# frozen_string_literal: true

class ChangeIntervalToFloatForParameterAttributes < ActiveRecord::Migration[6.1]
  def up
    change_column :parameters, :minimum, :float
    change_column :parameters, :maximum, :float
    change_column :parameters, :step, :float
  end

  def down
    change_column :parameters, :minimum, :integer
    change_column :parameters, :maximum, :integer
    change_column :parameters, :step, :integer
  end
end
