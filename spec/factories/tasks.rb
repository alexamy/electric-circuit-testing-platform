# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    arguments { { 'I' => 1, 'R' => 1 } }
    answer { 1 }
    user_answer { nil }
    question
    attempt
    association :author, factory: :user

    trait :wrong do
      user_answer { 2 }
    end

    trait :correct do
      user_answer { 1 }
    end
  end
end
