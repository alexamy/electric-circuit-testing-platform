# frozen_string_literal: true

class ParticularSolutionGenerator < ApplicationService
  attr_reader :question, :arguments, :answer

  def initialize(question)
    super()

    @question = question
    @arguments = {}
    @answer = nil
    @calculator = Dentaku::Calculator.new(case_sensitive: true)
  end

  def call
    set_arguments
    set_answer
    { arguments: arguments, answer: answer }
  end

  private

  attr_reader :calculator
  attr_writer :arguments, :answer

  def set_arguments
    question.formula_parameters.each do |parameter|
      arguments[parameter.name] = parameter.generate_value
    end
  end

  def set_answer
    bodies, target = question.formula.values_at(*%w[bodies target])
    solution = calculator.store(arguments).solve(bodies)
    self.answer = solution[target].round(question.precision)
  end
end