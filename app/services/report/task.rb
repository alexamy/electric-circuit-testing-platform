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

    def id
      @id ||= task.id
    end

    def question
      @question ||= task.question
    end

    def arguments
      @arguments ||= task.arguments
    end

    def arguments_text
      @arguments_text ||= arguments.map { |name, value| "#{name} = #{value}" }.join(', ')
    end

    def correct_answer
      @correct_answer ||= task.answer
    end

    def user_answer
      @user_answer ||= task.user_answer
    end

    def correct?
      @correct ||= task.correct?
    end
  end
end
