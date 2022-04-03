require 'faker'
100.times do |n|
  uuid  = Faker::Internet.uuid
  title = Faker::Book.title
  auther = Faker::Book.author
  publisher = Faker::Book.publisher
  published_on  = Faker::Date.between(from: '1980-01-01', to: '2022-01-01')
  series = Faker::Book.genre
  page_size = Faker::Number.number(digits: 3)
  Book.create!(
    {
      uuid: uuid,
      title: title,
      auther: auther,
      publisher: publisher,
      published_on: published_on,
      series: series,
      page_size: page_size
    }
  )
end
