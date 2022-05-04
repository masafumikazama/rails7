# frozen_string_literal: true

FactoryBot.define do
  factory :book_csv do
    association :manager
    imported_at { '2022-04-01' }
    manager_id { 1 }
    status { '完了' }
  end
end
