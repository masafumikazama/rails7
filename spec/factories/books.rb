FactoryBot.define do
  factory :book do
    uuid { "MyString" }
    title { "MyString" }
    auther { "MyString" }
    publisher { "MyString" }
    published_on { "2022-04-01" }
    series { "MyString" }
    page_size { 1 }
  end
end
