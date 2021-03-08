# frozen_string_literal: true

# pass string with lines of variable assignments, e.g.:
# Rx=R2*R3/(R2+R3)
# Vxmm1=VCC*Rx/(R1+Rx)
class FormulaParser < ApplicationService
  attr_reader :text, :target, :dependencies, :bodies

  def initialize(text)
    super()

    @text = text
    @calculator = Dentaku::Calculator.new(case_sensitive: true)

    parse
  end

  def call; end

  private

  attr_reader :calculator

  def parse
    entries = text.split("\n").map { |line| parse_one(line) }

    @target = entries.last[:target]
    @dependencies = entries.reverse.reduce([]) { |result, other| result + other[:dependencies] - [other[:target]] }
    @bodies = entries.map { |h| { h[:target] => h[:body] } }.reduce(&:merge).symbolize_keys
  end

  def parse_one(line)
    target, body = line.split('=')
    dependencies = calculator.dependencies(body)
    { body: body, target: target, dependencies: dependencies }
  end
end
