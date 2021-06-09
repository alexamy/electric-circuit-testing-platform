# frozen_string_literal: true

class Parameter < ApplicationRecord
  validate :validates_formula_dependency

  belongs_to :question

  private

  def validates_formula_dependency
    return unless question
    return if question.formula['dependencies'].include?(name)

    errors.add :name, :not_in_dependencies
  end
end
