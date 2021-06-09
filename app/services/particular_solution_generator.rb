# frozen_string_literal: true

class ParticularSolutionGenerator < ApplicationService
  attr_reader :question, :arguments, :answer

  def initialize(question)
    super()

    @question = question
    @arguments = {}
    @answer = nil
    @calculator = Calculator.new(case_sensitive: true)
  end

  def call
    set_arguments
    set_formula_arguments
    set_answer
    { arguments: arguments, answer: answer }
  end

  private

  attr_reader :calculator
  attr_writer :arguments, :answer

  def set_arguments
    question.parameters.reject(&:formula?).each do |parameter|
      arguments[parameter.name] = parameter.generate_value
    end

    calculator.store(arguments)
  end

  def set_formula_arguments
    question.parameters.select(&:formula?).each do |parameter|
      arguments[parameter.name] = calculator.evaluate(parameter.formula)
    end

    calculator.store(arguments)
  end

  def set_answer
    bodies, target = question.formula.values_at(*%w[bodies target])
    solution = calculator.solve!(bodies)
    self.answer = solution[target].round(question.precision)
  end
end
