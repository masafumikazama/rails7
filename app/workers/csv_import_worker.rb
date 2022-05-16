class CsvImportWorker
  include Shoryuken::Worker

  shoryuken_options queue: 'csv_import_worker', auto_delete: true, body_parser: :json

  def perform(sqs_msg, body)
    puts 'CSVインポート処理開始'
    # キューのメッセージにレコードのIDを入れてあるのでそれを元にレコードを特定
    puts body
    csv = BookCsv.find(body['book_csv_id']) # book_csvのcsvが格納されているカラムを参照
    tmp_file_path = Rails.root.join('tmp', 'csv_file.csv')

    # 一時ファイル書き込み
    pp tmp_file_path.inspect
    file_content = csv.csv_file.download
    File.open(tmp_file_path, 'wb') do |file|
      file.write(file_content)
    end

    ActiveRecord::Base.transaction do
      CSV.foreach(tmp_file_path, encoding: 'utf-8') do |row|
        unless row[0] == ''
          Book.create!(uuid: row[0], title: row[1], auther: row[2], publisher: row[3], published_on: row[4], series: row[5],
            page_size: row[6])
        end
        csv.update!(imported_at: Time.zone.now, status: '完了')
        puts sqs_msg, body
      end
    rescue StandardError
      csv.update!(imported_at: Time.zone.now, status: 'インポート失敗')
      puts sqs_msg, body
    end
    puts '処理終了'
    # 例外発生時を含め、一時ファイルは必ず削除する
  ensure
    File.delete(tmp_file_path) if File.exist?(tmp_file_path.to_s)
  end
end
