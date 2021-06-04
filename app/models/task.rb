# frozen_string_literal: true

class Task < ApplicationRecord
  include Authorable

  validates :arguments, :answer, presence: true
  validate :validates_formula_dependency

  belongs_to :question
  belongs_to :attempt

  def correct?
    user_answer == answer
  end

  def expired?
    Time.current > created_at + question.completion_time
  end

  def self.new_from(question)
    solution = ParticularSolutionGenerator.call(question)
    new(question: question, **solution)
  end

  private

  def validates_formula_dependency
    return unless question
    return if arguments.keys.difference(question.parameters.pluck(:name)).blank?

    errors.add :arguments, :not_in_dependencies
  end
end
