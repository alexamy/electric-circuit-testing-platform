# frozen_string_literal: true

def create_question(scheme_path, question_params, parameters)
  question = Question.new(**question_params)

  scheme = Rails.root.join(scheme_path)
  question.scheme.attach(io: File.open(scheme), filename: scheme.basename, content_type: 'image/png')

  question.save!

  parameters.each do |name, attributes|
    question.parameters.find_by(name: name).update(**attributes)
  end
end
