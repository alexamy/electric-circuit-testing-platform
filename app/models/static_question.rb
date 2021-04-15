# frozen_string_literal: true

class StaticQuestion < ApplicationRecord
  validates :arguments, :answer, presence: true
  validate :validates_formula_dependency

  belongs_to :question
  belongs_to :user

  def self.new_from(question)
    solution = ParticularSolutionGenerator.call(question)
    new(question: question, **solution)
  end

  private

  def validates_formula_dependency
    return unless question
    return if arguments.keys.difference(question.formula_parameters.pluck(:name)).blank?

    errors.add :arguments, :not_in_dependencies
  end
end
