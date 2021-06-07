# frozen_string_literal: true

require Rails.root.join('spec', 'support', 'upload_file')
require_relative 'question_seed'

namespace :seed do
  desc 'Generate questions'
  task :questions, [:author_email] => [:environment] do |_, args|
    QuestionSeed.seed(args.author_email)
  end
end
