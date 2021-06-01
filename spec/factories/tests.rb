# frozen_string_literal: true

FactoryBot.define do
  sequence :name do |n|
    "Test \##{n}"
  end

  factory :test do
    name
    target_score { 2 }

    trait :invalid do
      name { nil }
      target_score { -1 }
    end
  end
end
