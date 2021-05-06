# frozen_string_literal: true

module Formula
  class Parameter < ApplicationService
    MAPPING = {
      /^[uv]/i => :voltage,
      /^r/i => :resistance,
      /^d/i => :diameter,
      /^_test$/ => :test
    }.freeze

    def initialize(name)
      super()

      @name = name
    end

    def call
      MAPPING.each do |regex, method|
        return send(method) if @name.match(regex)
      end

      default
    end

    private

    def default
      { minimum: 1, maximum: 10, step: 1 }
    end

    def voltage
      { minimum: 2, maximum: 50, step: 1, unit: 'В' }
    end

    def resistance
      { minimum: 10, maximum: 1_000_000, step: 100, unit: 'Ом' }
    end

    def diameter
      { minimum: 5, maximum: 20, step: 1, unit: 'мм' }
    end

    def test
      { minimum: 1, maximum: 1, step: 1, unit: 'test' }
    end
  end
end
