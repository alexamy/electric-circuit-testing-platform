# frozen_string_literal: true

class TestAttempt < ApplicationRecord
  belongs_to :category

  has_many :static_questions, dependent: :destroy
end
