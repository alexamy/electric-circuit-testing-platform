# frozen_string_literal: true

class StepParameter < Parameter
  validates :name, :minimum, :maximum, :step, presence: true
  validates :minimum, numericality: { less_than_or_equal_to: ->(parameter) { parameter.maximum } }

  def generate_value
    return minimum unless step.positive?

    result = generate_value_raw
    result.frac.zero? ? result.to_i : result
  end

  private

  def generate_value_raw
    offset = (maximum - minimum) / step + 1
    minimum + rand(offset) * step.to_d
  end
end
