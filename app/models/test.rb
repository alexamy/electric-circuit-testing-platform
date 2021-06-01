# frozen_string_literal: true

class Test < ApplicationRecord
  CORRECT_SCORE = 1
  WRONG_SCORE = -2

  validates :name, :target_score, presence: true
  validates :target_score, numericality: {
    only_integer: true,
    greater_than: 0
  }

  has_many :questions, dependent: :destroy
  has_many :test_attempts, dependent: :nullify

  scope :with_questions, -> { joins(:questions).distinct }

  def score_of(user)
    corrects, wrongs = StaticQuestion.joins(:question)
                                     .where(author: user, questions: { category: self })
                                     .partition(&:correct?)
                                     .map(&:count)

    corrects * CORRECT_SCORE + wrongs * WRONG_SCORE
  end

  def passed?(user)
    score_of(user) >= target_score
  end
end
