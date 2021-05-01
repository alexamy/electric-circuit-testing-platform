# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength
def create_question(scheme_path, question_params, parameters)
  question = Question.new(**question_params)

  question.formula = Formula::Parser.call(question.formula_text)
  question.formula['dependencies'].each do |name|
    question.formula_parameters.new(name: name, **parameters[name])
  end

  scheme = Rails.root.join(scheme_path)
  question.scheme.attach(
    io: File.open(scheme),
    filename: scheme.basename,
    content_type: 'image/png'
  )

  question.save
end
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
