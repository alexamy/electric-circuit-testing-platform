# frozen_string_literal: true

class Calculator < Dentaku::Calculator
  def initialize(*args, **kwargs, &block)
    super(*args, **kwargs, &block)
    add_function_clamp
    add_function_rand
  end

  private

  def add_function_clamp
    add_function :clamp, :numeric, (lambda do |val, min, max|
      return min if val < min
      return max if val > max

      val
    end)
  end

  def add_function_rand
    add_function :rand, :numeric, ->(max) { rand(max) }
  end
end
