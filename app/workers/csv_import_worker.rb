class CsvImportWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'csv_import_worker', auto_delete: true, body_parser: :json

  def perform(sqs_msg, body)
    CSV.foreach('./import_csv_rails7.csv', headers: true) do |row|
      book = Book.find_by(uuid: row['uuid']) || new
      book.attributes = row.to_hash.slice(*updatable_attributes)
      book.save
      puts sqs_msg, body
    end
  end

  def updatable_attributes
    %w[uuid title auther publisher published_on series page_size]
  end
end
