# frozen_string_literal: true

require 'question_seed'

namespace :seed do
  desc 'Generate questions'
  task questions: [:environment] do
    QuestionSeed.seed
  end
end
