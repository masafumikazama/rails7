require 'elasticsearch/model'

class Book < ApplicationRecord
  include Books::Searchable
  before_create -> { self.uuid = SecureRandom.uuid }
  attribute :uuid, :string, default: -> { SecureRandom.uuid }

  validates :uuid, { presence: true }
  validates :title, { presence: true, length: { maximum: 30 } }
  validates :page_size, { presence: true }

  def to_param
    uuid
  end

  def self.import(file)
    Shoryuken.configure_client do |config|
      sqs_client = config.sqs_client
      queue_url = sqs_client.get_queue_url(queue_name: 'csv_import_worker')['queue_url']
      sqs_client.send_message(queue_url: queue_url, message_body: { "hoge": "fuge" }.to_json)
    end
  end
end
