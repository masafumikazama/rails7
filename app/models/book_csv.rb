class BookCsv < ApplicationRecord
  has_one_attached :csv_file
  belongs_to :manager
end
