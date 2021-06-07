# frozen_string_literal: true

require 'require_all'
require_rel 'questions'

module QuestionSeed
  def self.data
    [Questions::Chapter1]
  end

  # :reek:TooManyStatements
  def self.seed(author_email)
    raise ArgumentError, 'Blank email argument!' if author_email.blank?

    admin = Admin.find_by!(email: author_email)

    data.each do |collection|
      next if Test.find_by(**collection::TEST)

      test = Test.create!(**collection::TEST)
      seed_by(collection::QUESTIONS, test: test, author: admin)
    end
  end

  def self.seed_by(questions, **attributes)
    questions.map do |_, info|
      FactoryBot.create(:question, **info, **attributes)
    end
  end
end
