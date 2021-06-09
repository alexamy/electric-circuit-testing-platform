# frozen_string_literal: true

class EnumParameter < Parameter
  validates :variants, presence: true
  validate :validates_numericality_of_variants

  serialize :variants, Array

  def generate_value
    variants.sample
  end

  private

  def validates_numericality_of_variants
    return if variants.all?(Numeric)

    errors.add :variants, :not_numeric
  end
end
