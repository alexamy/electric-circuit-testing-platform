# frozen_string_literal: true

require_relative 'questions/chapter_1'

class QuestionSeed
  def self.seed
    Questions::Chapter1::DATA.map.with_index(Questions::Chapter1::START_ID) do |info, id|
      FactoryBot.create(:question, id: id, **info)
    end
  end
end
