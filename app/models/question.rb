# frozen_string_literal: true

class Question < ApplicationRecord
  validates :text, :formula, presence: true

  belongs_to :category
end
