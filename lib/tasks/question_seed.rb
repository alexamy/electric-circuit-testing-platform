# frozen_string_literal: true

require_relative 'questions/chapter_1'

class QuestionSeed
  def self.data
    [Questions::Chapter1]
  end

  def self.seed
    data.each do |collection|
      seed_by(collection::QUESTIONS, collection::START_ID)
    end
  end

  def self.seed_by(questions, start_id)
    questions.map.with_index(start_id) do |info, id|
      next if Question.find_by(id: id)

      FactoryBot.create(:question, id: id, **info)
    end
  end
end
