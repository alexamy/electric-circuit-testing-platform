# frozen_string_literal: true

class FormulaParameter < ApplicationRecord
  validates :name, :minimum, :maximum, :step, :unit, presence: true
  validate :validates_range

  belongs_to :question

  private

  def validates_range
    return unless minimum && maximum
    return if minimum <= maximum

    errors.add :minimum, :less_than_maximum
  end
end
