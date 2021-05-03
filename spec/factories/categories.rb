# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Test category \##{n}"
  end

  factory :category do
    name
    target_score { 2 }

    trait :invalid do
      name { nil }
      target_score { -1 }
    end
  end
end
