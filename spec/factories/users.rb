# frozen_string_literal: true

FactoryBot.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user, aliases: [:student], class: 'Student' do
    email
    password { '123456' }
    password_confirmation { '123456' }
    group
  end

  factory :admin do
    email
    password { '123456' }
    password_confirmation { '123456' }
  end
end
