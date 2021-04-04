# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    formula_text { "V=R" }
    text { "Найти V" }
    comment { "Comment" }
    precision { 0 }
    formula { { target: "V", dependencies: %w[R], bodies: { V: "R" } } }
    category
  end
end
