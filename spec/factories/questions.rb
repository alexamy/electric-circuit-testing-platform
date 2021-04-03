# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    formula_text { "V=R" }
    text { "Найти V" }
    comment { "" }
    formula { { target: "V", dependencies: %i[R], bodies: { V: "R" } } }
    category
  end
end
