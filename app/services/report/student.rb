# frozen_string_literal: true

module Report
  class Student
    attr_reader :user, :test

    def initialize(user, test)
      @user = user
      @test = test
    end

    def id
      @id ||= test.id
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
                       .filter { |answer| answer.author == user }
    end

    def answer_counts
      @answer_counts ||= answers.partition(&:correct?).map(&:count)
    end

    def answer_count
      @answer_count = answer_counts.sum
    end

    def correctness
      return 0 if answer_counts.all?(&:zero?)

      @correctness ||= answer_counts.first / answer_count.to_f
    end

    def attempts
      @attempts ||= TestAttempt.all.where(author: user).where(category: test)
    end
  end
end
