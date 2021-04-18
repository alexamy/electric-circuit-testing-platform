# frozen_string_literal: true

FactoryBot.define do
  factory :static_question do
    arguments { { 'V' => 1 } }
    answer { 1 }
    user_answer { 1 }
    question factory: :question, formula: { target: 'R', dependencies: %w[V], bodies: { V: 'R' } }
    association :author, factory: :user

    trait :invalid do
      user_answer { 2 }
    end
  end
end
