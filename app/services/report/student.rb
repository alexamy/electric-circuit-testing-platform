# frozen_string_literal: true

module Report
  class Student
    attr_reader :user, :test

    def initialize(user, test)
      super()

      @user = user
      @test = test
    end

    def name
      @name ||= test.name
    end

    def target_score
      @target_score ||= test.target_score
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

    def attempts
      @attempts ||= TestAttempt.all.where(author: user).where(category: test)
    end
  end
end
