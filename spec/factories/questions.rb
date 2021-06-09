# frozen_string_literal: true

# :reek:UtilityFunction
def parameters_to_hash(parameters)
  return parameters if parameters.is_a?(Hash)

  parameters.map(&:to_s).index_with({})
end

FactoryBot.define do
  factory :question do
    transient do
      scheme_path { nil }
      parameters do
        {
          'I' => { minimum: 2, maximum: 50, step: 1, unit: 'А' },
          'R' => { minimum: 100, maximum: 100_000, step: 100, unit: 'Ом' }
        }
      end
    end

    formula_text { 'V=I*R' }
    text { 'Найти V' }
    comment { nil }
    precision { 0 }
    answer_unit { 'Unit' }
    completion_time { 5 } # seconds
    scheme { create_file(scheme_path) if scheme_path }
    test
    association :author, factory: :admin

    after(:create) do |question, evaluator|
      parameters_to_hash(evaluator.parameters).each do |name, info|
        type = info[:factory] || :step_parameter
        create(type, question: question, name: name, **info.except(:factory))
      end
    end

    trait :with_scheme do
      scheme_path { 'spec/support/files/397KB.png' }
    end
  end
end
