# frozen_string_literal: true

require 'factory_bot'
FactoryBot.find_definitions

require 'require_all'
require_rel 'questions'

module QuestionSeed
  # :reek:DuplicateMethodCall
  def self.log(message)
    Rails.logger.tagged('SEED') { Rails.logger.info { message } }
  end

  def self.data
    Questions.constants.sort.map { |chapter| Questions.const_get(chapter) }
  end

  # :reek:TooManyStatements
  def self.seed(author_email)
    raise ArgumentError, 'Blank email argument!' if author_email.blank?

    admin = Admin.find_by!(email: author_email)

    data.each do |collection|
      test = collection::TEST
      next if Test.find_by(**test)

      log "Generating test #{test[:name]}"
      test = Test.create!(**test)
      seed_by(collection::QUESTIONS, test: test, author: admin)
    end
  end

  def self.seed_by(questions, **attributes)
    questions.map do |index, info|
      log "Generating question #{index}"
      FactoryBot.create(:question, **info, **attributes)
    end
  end
end
