# frozen_string_literal: true

FactoryBot.define do
  factory :manager do
    sequence(:email) { |n| "manager#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
    confirmed_at { Date.today }
    role { 'admin' }
  end
end
