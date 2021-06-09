# frozen_string_literal: true

class FormulaParameter < Parameter
  validates :formula, presence: true

  def generate_value
    formula
  end
end
