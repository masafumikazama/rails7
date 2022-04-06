class CsvImportWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'csv_import_worker', auto_delete: true, body_parser: :json

  # def perform(sqs_msg, body)
  #   puts sqs_msg, body
  #   puts "処理開始"
  #   CSV.foreach(file.path, headers: true) do |row, index|
  #     book = Book.new
  #     book.attributes = row.to_hash.slice(*updatable_attributes)
  #     book.save!
  #     ProgressChannel.broadcast_to(
  #       percent: (index+1) * 100 / pictures.length
  #    )
  #     puts sqs_msg, body
  #   end
  #   puts "処理終了"
  # end

  def perform(sqs_msg, body)
    puts "CSVインポート処理開始"
    # キューのメッセージにレコードのIDを入れてあるのでそれを元にレコードを特定
    csv = BookCsv.find(body.values).csv_file # book_csvのcsvが格納されているカラムを参照
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
