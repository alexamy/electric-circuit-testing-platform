# frozen_string_literal: true

FactoryBot.define do
  factory :step_parameter, aliases: [:parameter] do
    name { 'Parameter' }
    minimum { 1 }
    maximum { 1 }
    step { 1 }
    unit { 'Unit' }
    question

    trait :invalid_range do
      minimum { 100 }
      maximum { 1 }
    end
  end
end
