# frozen_string_literal: true

module QuestionSeed
  QUESTION_DIRECTORY = 'lib/assets/questions'

  # :reek:DuplicateMethodCall
  def self.log(message)
    Rails.logger.tagged('SEED') { Rails.logger.info { message } }
  end

  def self.data
    files = Dir[Rails.root.join(QUESTION_DIRECTORY, '*.yml')].sort
    files.map { |path| YAML.safe_load(File.open(path)).deep_symbolize_keys }
  end

  # :reek:TooManyStatements
  def self.seed(author_email)
    raise ArgumentError, 'Blank email argument!' if author_email.blank?

    teacher = Teacher.find_by!(email: author_email)

    data.each do |collection|
      test = collection[:test]
      next if Test.find_by(**test)

      log "Generating test #{test[:name]}"
      test = Test.create!(**test)
      seed_by(collection[:questions], test: test, author: teacher)
    end
  end

  def self.seed_by(questions, **attributes)
    questions.map.with_index(1) do |question, index|
      log "Generating question #{index}"
      FactoryBot.create(:question, **question, **attributes)
    end
  end
end
