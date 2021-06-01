# frozen_string_literal: true

FactoryBot.define do
  factory :attempt do
    test
    association :author, factory: :user
  end
end
