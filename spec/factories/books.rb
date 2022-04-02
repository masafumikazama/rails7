FactoryBot.define do
  factory :book do
    uuid { 'f3c93ae1-9ad9-4693-864c-44a502604eaa' }
    title { 'サンプルタイトル' }
    auther { 'サンプル著者' }
    publisher { 'サンプル出版社' }
    published_on { '2022-04-01' }
    series { 'サンプルシリーズ' }
    page_size { 100 }
  end
end
