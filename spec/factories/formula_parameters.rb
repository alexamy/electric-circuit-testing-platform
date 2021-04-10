# frozen_string_literal: true

FactoryBot.define do
  factory :formula_parameter do
    name { 'Parameter' }
    minimum { 1 }
    maximum { 100 }
    step { 10 }
    unit { 'Unit' }
    question

    trait :invalid_range do
      minimum { 100 }
      maximum { 1 }
    end
  end
end
