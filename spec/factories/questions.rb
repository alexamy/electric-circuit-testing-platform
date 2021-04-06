# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    formula_text { "V=I*R" }
    text { "Найти V" }
    comment { "Comment" }
    precision { 0 }
    formula { { target: "V", dependencies: %w[I R], bodies: { V: "I*R" } } }
    category

    after(:create) do |question|
      question.formula["dependencies"].each do |dependency|
        create(:formula_parameter, name: dependency, question: question)
      end
    end
  end
end
