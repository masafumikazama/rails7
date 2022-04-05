class CsvImportWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'csv_import_worker', auto_delete: true, body_parser: :json

  def perform(sqs_msg, body)
    puts "CSVインポート処理開始"
    # キューのメッセージにレコードのIDを入れてあるのでそれを元にレコードを特定
    csv = BookCsv.find(body['book_csv_id']).csv # book_csvのcsvが格納されているカラムを参照
    CSV.foreach(csv, headers: true) do |row|
      book = Book.new
      book.attributes = row.to_hash.slice(*updatable_attributes)
      book.save!
      puts sqs_msg, body
    end
    puts "処理終了"
  end

  def updatable_attributes
    %w[uuid title auther publisher published_on series page_size]
  end
end
