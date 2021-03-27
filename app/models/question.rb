# frozen_string_literal: true

class Question < ApplicationRecord
  validates :text, :formula, presence: true

  belongs_to :category

  has_many :formula_parameters, dependent: :destroy

  accepts_nested_attributes_for :formula_parameters
end
