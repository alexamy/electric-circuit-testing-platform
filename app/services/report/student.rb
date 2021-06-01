# frozen_string_literal: true

module Report
  class Student < ApplicationService
    attr_reader :user, :test

    def initialize(user, test)
      super()

      @user = user
      @test = test
      answers
    end

    def call
      {
        name: test.name,
        target_score: test.target_score,
        score: score,
        correctness: correctness,
        correctness_percentage: correctness_percentage,
        attempts: attempts
      }
    end

    def score
      @score ||= test.score_of(user)
    end

    def answers
      @answers ||= test.questions.includes(:static_questions)
                       .map(&:static_questions).flatten
    end

    def answer_counts
      @answer_counts ||= answers.partition(&:correct?).map(&:count)
    end

    def correctness
      @correctness ||= answer_counts.first / answer_counts.sum.to_f
    end

    def correctness_percentage
      @correctness_percentage ||= "#{(correctness * 100).to_i}%"
    end

    def attempts
      @attempts ||= TestAttempt.all.where(author: user).where(category: test).count
    end
  end
end
