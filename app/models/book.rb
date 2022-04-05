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

  # importメソッド
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      book = find_by(uuid: row['uuid']) || new
      # CSVからデータを取得し、設定する
      book.attributes = row.to_hash.slice(*updatable_attributes)
      book.save
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    %w[uuid title auther publisher published_on series page_size]
  end
end

def self.import(file)
  Shoryuken.configure_client do |config|
    sqs_client = config.sqs_client
    queue_url = sqs_client.get_queue_url(queue_name: 'csv_import_worker')['queue_url']
  end
end

# 更新を許可するカラムを定義
def self.updatable_attributes
  %w[uuid title auther publisher published_on series page_size]
end
