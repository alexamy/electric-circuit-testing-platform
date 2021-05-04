# frozen_string_literal: true

class Question < ApplicationRecord
  include Authorable

  validates :text, :formula, :formula_text, :precision, :answer_unit, presence: true
  validates :scheme, presence: true, blob: { content_type: :image, size_range: 1..1.megabytes }
  validates :precision, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :completion_time, allow_nil: true, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }

  belongs_to :category

  has_many :formula_parameters, dependent: :destroy
  has_many :static_questions, dependent: :nullify

  has_one_attached :scheme

  accepts_nested_attributes_for :formula_parameters
end
