# frozen_string_literal: true

class Category < ApplicationRecord
  CORRECT_SCORE = 1
  WRONG_SCORE = -2

  validates :name, :target_score, presence: true

  has_many :questions, dependent: :destroy

  def score_of(user)
    corrects, wrongs = StaticQuestion.joins(:question)
                                     .where(author: user, questions: { category: self })
                                     .partition(&:correct?)
                                     .map(&:count)

    corrects * CORRECT_SCORE + wrongs * WRONG_SCORE
  end
end
