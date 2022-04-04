# frozen_string_literal: true

module Managers
  class ImportBooksController < Managers::Base
    def new; end

    def create
      Shoryuken.configure_client do |config|
        sqs_client = config.sqs_client
        queue_url = sqs_client.get_queue_url(queue_name: 'csv_import_worker')['queue_url']
        sqs_client.send_message(queue_url: queue_url, message_body: { "hoge": 'fuge' }.to_json)
      end
      redirect_to root_path
    end
  end
end
