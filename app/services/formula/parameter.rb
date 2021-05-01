# frozen_string_literal: true

module Formula
  class Parameter < ApplicationService
    def initialize(name)
      @name = name
    end

    def call
      case @name
      when /^[uv]/i
        voltage
      when /^r/i
        resistance
      when /^d/i
        diameter
      else
        default
      end
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
  end
end
