# frozen_string_literal: true

FactoryBot.define do
  factory :test_attempt do
    category
    association :author, factory: :user
  end
end