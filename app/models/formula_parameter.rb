# frozen_string_literal: true

class FormulaParameter < ApplicationRecord
  validates :name, :minimum, :maximum, :step, :unit, presence: true

  belongs_to :question
end
