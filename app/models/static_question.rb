# frozen_string_literal: true

class StaticQuestion < ApplicationRecord
  validates :arguments, :answer, presence: true
  validate :validates_formula_dependency

  belongs_to :question

  private

  def validates_formula_dependency
    return unless question
    return if arguments.keys.difference(question.formula_parameters.select(:name)).blank?

    errors.add :arguments, :not_in_dependencies
  end
end
