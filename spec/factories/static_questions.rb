# frozen_string_literal: true

FactoryBot.define do
  factory :static_question do
    arguments { { "V" => 1 } }
    answer { 1 }
    question factory: :question, formula: { target: "R", dependencies: %w[V], bodies: { V: "R" } }
  end
end
