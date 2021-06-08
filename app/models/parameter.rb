# frozen_string_literal: true

class Parameter < ApplicationRecord
  validates :name, :minimum, :maximum, :step, presence: true
  validates :minimum, numericality: { less_than_or_equal_to: ->(parameter) { parameter.maximum } }
  validate :validates_formula_dependency

  belongs_to :question

  def generate_value
    return minimum unless step.positive?

    offset = (maximum - minimum) / step + 1
    minimum + rand(offset) * step.to_d
  end

  private

  def validates_formula_dependency
    return unless question
    return if question.formula['dependencies'].include?(name)

    errors.add :name, :not_in_dependencies
  end
end
