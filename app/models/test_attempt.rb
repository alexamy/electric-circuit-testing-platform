# frozen_string_literal: true

class TestAttempt < ApplicationRecord
  belongs_to :category

  has_many :static_questions, dependent: :destroy

  def latest?
    self.class.maximum(:created_at) == created_at
  end
end
