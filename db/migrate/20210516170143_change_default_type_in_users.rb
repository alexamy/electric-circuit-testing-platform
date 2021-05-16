# frozen_string_literal: true

class ChangeDefaultTypeInUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :type, 'Student'
  end
end
