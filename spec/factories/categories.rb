# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { 'Test category' }
    target_score { 2 }
  end
end
