# frozen_string_literal: true

class StaticQuestion < ApplicationRecord
  validates :arguments, :answer, presence: true
  validate :validates_formula_dependency

  belongs_to :question
  belongs_to :author, class_name: 'User', inverse_of: 'static_questions'
  belongs_to :test_attempt

  def correct?
    user_answer == answer
  end

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
