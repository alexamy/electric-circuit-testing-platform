# frozen_string_literal: true

module Report
  class Task
    attr_reader :task

    def initialize(task)
      @task = task
    end

    def self.answers(user, test)
      test.questions.includes(:static_questions)
          .map(&:static_questions).flatten
          .filter { |answer| answer.author == user }
    end

    def question
      @question ||= task.question
    end
  end
end
