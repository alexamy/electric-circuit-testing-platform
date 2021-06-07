# frozen_string_literal: true

# :reek:UtilityFunction
def parameters_to_hash(parameters)
  return parameters if parameters.is_a?(Hash)

  parameters.map(&:to_s).index_with({})
end

FactoryBot.define do
  sequence :comment do |n|
    "Comment of question ##{n}"
  end

  factory :question do
    transient do
      scheme_path { 'spec/support/files/397KB.png' }
      parameters do
        {
          'I' => { minimum: 2, maximum: 50, step: 1, unit: 'А' },
          'R' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' }
        }
      end
    end

    formula_text { 'V=I*R' }
    text { 'Найти V' }
    comment
    precision { 0 }
    answer_unit { 'Unit' }
    completion_time { 5 } # seconds
    scheme { create_file(scheme_path) }
    test
    association :author, factory: :admin

    after(:create) do |question, evaluator|
      parameters_to_hash(evaluator.parameters).each do |name, info|
        create(:parameter, question: question, name: name, **info)
      end
    end
  end
end
