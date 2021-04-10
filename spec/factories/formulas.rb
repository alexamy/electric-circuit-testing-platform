# frozen_string_literal: true

FactoryBot.define do
  factory :text_formula, class: 'String' do
    text { "Rx=R2*R3/(R2+R3)\n Vxmm1=VCC*Rx/(R1+Rx)" }

    trait :invalid do
      text { "**** \n error" }
    end

    initialize_with { new(text) }
  end
end
