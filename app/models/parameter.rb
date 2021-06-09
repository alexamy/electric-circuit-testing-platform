# frozen_string_literal: true

class Parameter < ApplicationRecord
  validate :validates_formula_dependency

  belongs_to :question

  def step?
    is_a?(StepParameter)
  end

  def enum?
    is_a?(EnumParameter)
  end

  def formula?
    is_a?(FormulaParameter)
  end

  private

  def validates_formula_dependency
    return unless question
    return if question.formula['dependencies'].include?(name)

    errors.add :name, :not_in_dependencies
  end
end
