# frozen_string_literal: true

FactoryBot.define do
  sequence :comment do |n|
    "Comment of question ##{n}"
  end

  factory :question do
    formula_text { 'V=I*R' }
    text { 'Найти V' }
    comment
    precision { 0 }
    answer_unit { 'Unit' }
    formula { { target: 'V', dependencies: %w[I R], bodies: { V: 'I*R' } } }
    scheme { create_file('spec/support/files/397KB.png') }
    category
    author

    after(:create) do |question|
      question.formula['dependencies'].each do |dependency|
        create(:formula_parameter, name: dependency, question: question)
      end
    end
  end
end
