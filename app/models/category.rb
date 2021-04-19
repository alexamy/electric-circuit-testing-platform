# frozen_string_literal: true

class Category < ApplicationRecord
  CORRECT_SCORE = 1
  WRONG_SCORE = -2

  validates :name, :target_score, presence: true

  has_many :questions, dependent: :destroy

  # :reek:FeatureEnvy
  def score_of(user)
    correct, wrong = StaticQuestion.where(author: user)
                                   .joins(:question)
                                   .where(questions: { category: self })
                                   .select(:answer, :user_answer)
                                   .partition { |question| question.answer == question.user_answer }
                                   .map(&:count)

    correct * CORRECT_SCORE + wrong * WRONG_SCORE
  end
end
