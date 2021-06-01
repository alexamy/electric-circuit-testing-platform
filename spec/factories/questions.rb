# frozen_string_literal: true

FactoryBot.define do
  sequence :comment do |n|
    "Comment of question ##{n}"
  end

  factory :question do
    formula_text { 'V=I*R' }
    text { 'Найти V' }
    comment
    precision { 0 }
    answer_unit { 'Unit' }
    completion_time { 5 } # seconds
    scheme { create_file('spec/support/files/397KB.png') }
    test
    association :author, factory: :admin
  end
end
