# frozen_string_literal: true

class Question < ApplicationRecord
  validates :text, :formula, :precision, presence: true
  validates :precision, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  belongs_to :category

  has_many :formula_parameters, dependent: :destroy

  accepts_nested_attributes_for :formula_parameters
end
