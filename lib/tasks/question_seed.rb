# frozen_string_literal: true

require_relative 'questions/chapter_1'

class QuestionSeed
  def self.seed(author_email)
    raise ArgumentError, 'Blank email argument!' if author_email.blank?

    admin = Admin.find_by!(email: author_email)

    data.each do |collection|
      test = Test.find_or_create_by(**collection::TEST)
      seed_by(collection::QUESTIONS, collection::START_ID, test: test, author: admin)
    end
  end

  def self.seed_by(questions, start_id, **kwargs)
    questions.map.with_index(start_id) do |info, id|
      next if Question.find_by(id: id)

      FactoryBot.create(:question, id: id, **info, **kwargs)
    end
  end

  def self.data
    [Questions::Chapter1]
  end
end
