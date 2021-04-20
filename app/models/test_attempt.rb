# frozen_string_literal: true

class TestAttempt < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', inverse_of: 'test_attempts'

  has_many :static_questions, dependent: :destroy

  def latest?
    TestAttempt.where(author: author).maximum(:created_at) == created_at
  end
end
