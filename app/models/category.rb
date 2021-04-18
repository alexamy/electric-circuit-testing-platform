# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, :target_score, presence: true

  has_many :questions, dependent: :destroy
end
