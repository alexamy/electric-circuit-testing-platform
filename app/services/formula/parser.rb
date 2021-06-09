# frozen_string_literal: true

module Formula
  class Parser < ApplicationService
    attr_reader :text, :target, :dependencies, :bodies

    def initialize(text)
      super()

      @text = Formula::Normalizer.normalize(text)
      @calculator = Calculator.new(case_sensitive: true)
    end

    def call
      find_entries
      find_target
      find_dependencies
      find_bodies

      { target: target, dependencies: dependencies, bodies: bodies }
    end

    private

    attr_reader :calculator, :entries

    def parse_one(line)
      target, body = line.split('=').map(&:strip)
      dependencies = calculator.dependencies(body)
      { target: target, body: body, dependencies: dependencies }
    end

    def find_entries
      @entries = @text.split("\n").map { |line| parse_one(line.strip) }
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
end
