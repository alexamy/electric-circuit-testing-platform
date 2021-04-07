# frozen_string_literal: true

class FormulaParameter < ApplicationRecord
  validates :name, :minimum, :maximum, :step, :unit, presence: true
  validate :validates_range, :validates_formula_dependency

  belongs_to :question

  def generate_value
    return minimum unless step.positive?

    offset = (maximum - minimum) / step + 1
    minimum + rand(offset) * step
  end

  private

  def validates_range
    return unless minimum && maximum
    return if minimum <= maximum

    errors.add :minimum, :less_than_maximum
  end

  def validates_formula_dependency
    return unless question
    return if question.formula["dependencies"].include?(name)

    errors.add :name, :not_in_dependencies
  end
end
