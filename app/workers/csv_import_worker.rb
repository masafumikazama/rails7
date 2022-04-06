class CsvImportWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'csv_import_worker', auto_delete: true, body_parser: :json

  def perform(sqs_msg, body)
    puts "CSVインポート処理開始"
    # キューのメッセージにレコードのIDを入れてあるのでそれを元にレコードを特定
    csv = BookCsv.find(body.values) # book_csvのcsvが格納されているカラムを参照
    tmp_file_path = Rails.root.join('tmp', 'csv_file.csv')

    # 一時ファイル書き込み
    binding.irb
    file_content = csv.csv_file.download
    File.open(tmp_file_path, 'wb') do |file|
      file.write(file_content)
    end
    ActiveRecord::Base.transaction do
      CSV.foreach(tmp_file_path, encoding: 'CP932:UTF-8') do |row|
        Book.create!(uuid: row[0], title: row[1], auther: row[2], publisher: row[3], published_on: row[4], series: row[5], page_size: row[6])
        csv.update!(imported_at: Time.zone.now)
        puts sqs_msg, body
      end
    end
    puts "処理終了"
    # 例外発生時を含め、一時ファイルは必ず削除する
    ensure
      File.delete(tmp_file_path) if File.exist?(tmp_file_path)
  end
end


# def perform(sqs_msg, body)
#   puts "CSVインポート処理開始"
#   # キューのメッセージにレコードのIDを入れてあるのでそれを元にレコードを特定
#   csv = BookCsv.find(body.values).csv_file.read # book_csvのcsvが格納されているカラムを参照
#   CSV.foreach(csv, headers: true) do |row|
#     book = Book.new
#     book.attributes = row.to_hash.slice(*updatable_attributes)
#     book.save!
#     puts sqs_msg, body
#   end
#   puts "処理終了"
# end

# def updatable_attributes
#   %w[uuid title auther publisher published_on series page_size]
# end
