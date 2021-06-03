# frozen_string_literal: true

module Report
  class Task
    attr_reader :task

    def initialize(task)
      @task = task
    end

    def self.answers(user, test)
      StaticQuestion
        .includes(:attempt)
        .where(author: user, attempts: { test: test })
        .order(:created_at)
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
      @arguments_text ||= arguments.map { |name, value| "#{name} = #{value}" }.join("\n")
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

    def created_at
      @created_at ||= task.created_at
    end

    def answered_at
      @answered_at ||= task.updated_at
    end

    def answer_duration
      @answer_duration ||= user_answer ? (answered_at - created_at).seconds : nil
    end

    def scheme
      @scheme ||= task.question.scheme
    end
  end
end
