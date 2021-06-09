# frozen_string_literal: true

class Calculator < Dentaku::Calculator
  def initialize(*args, **kwargs, &block)
    super(*args, **kwargs, &block)
    add_clamp_function
  end

  private

  def add_clamp_function
    add_function :clamp, :numeric, (lambda do |val, min, max|
      return min if val < min
      return max if val > max

      val
    end)
  end
end
