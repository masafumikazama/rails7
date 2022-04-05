# frozen_string_literal: true

module Managers
  class ImportBooksController < Managers::Base
    def new; end

    def create
      # csvを一旦ストレージに保存（画像保存と一緒）、参照情報だけDBに保存（新たにテーブルが必要）。
      book_csv = BookCsv.new(params)
      book_csv.save!
      # 以下でキューにメッセージを送る
      Shoryuken.configure_client do |config|
        sqs_client = config.sqs_client
        queue_url = sqs_client.get_queue_url(queue_name: 'csv_import_worker')['queue_url']
        sqs_client.send_message(queue_url: queue_url, message_body: { "book_csv_id": book_csv.id }.to_json)
      end
      flash[:notice] = "インポート処理を開始しました！"
      redirect_to managers_import_books_path
    end
  end
end
