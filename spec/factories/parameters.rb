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

  factory :enum_parameter do
    name { 'Parameter' }
    variants { [1, 2, 3] }
    unit { 'Unit' }
    question

    trait :invalid_variants do
      variants { [1, 'invalid', 3] }
    end
  end

  factory :formula_parameter do
    name { 'Parameter' }
    formula { '' }
    unit { 'Unit' }
    question
  end
end
