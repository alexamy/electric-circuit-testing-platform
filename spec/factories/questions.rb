# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    formula_text { "MyString" }
    text { "MyString" }
    comment { "MyString" }
    formula { "" }
    category
  end
end
