# frozen_string_literal: true

FactoryBot.define do
  factory :parameter do
    minimum { 1 }
    maximum { 100 }
    step { 10 }
    unit { "Unit" }
    question
  end
end
