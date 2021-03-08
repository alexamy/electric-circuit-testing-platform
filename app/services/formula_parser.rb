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
    @entries = text.split("\n").map { |line| parse_one(line) }

    parse
  end

  def call; end

  private

  attr_reader :calculator, :entries

  def parse_one(line)
    target, body = line.split('=')
    dependencies = calculator.dependencies(body)
    { target: target, body: body, dependencies: dependencies }
  end

  def parse
    find_target
    find_dependencies
    find_bodies
  end

  def find_target
    @target = entries.last[:target]
  end

  def find_dependencies
    @dependencies = entries.reverse.reduce([]) { |result, other| result + other[:dependencies] - [other[:target]] }
  end

  def find_bodies
    @bodies = entries.map { |entry| [entry[:target], entry[:body]] }.to_h.symbolize_keys
  end
end
