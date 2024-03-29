# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name { 'Group' }
    year { 2021 }
  end

  trait :invalid do
    year { nil }
  end
end
