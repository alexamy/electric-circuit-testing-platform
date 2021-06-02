# frozen_string_literal: true

module Report
  class Test
    attr_reader :user, :test

    def initialize(user, test)
      @user = user
      @test = test
    end

    def answers
      @answers ||= test.questions.includes(:static_questions)
                       .map(&:static_questions).flatten
                       .filter { |answer| answer.author == user }
    end
  end
end
