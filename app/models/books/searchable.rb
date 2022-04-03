module Books
  require 'elasticsearch/model'

  module Searchable
    extend ActiveSupport::Concern

    included do
      include Elasticsearch::Model
      include Elasticsearch::Model::Callbacks

      # ①index名
      index_name "es_rails7_#{Rails.env}"

      # ②mapping情報
      settings do
        mappings dynamic: 'false' do
          indexes :id,        type: 'integer'
          indexes :title,     type: 'keyword'
          indexes :auther,    type: 'keyword'
          indexes :publisher, type: 'text'
          indexes :series,    type: 'text'
        end
      end

      # ③mappingの定義に合わせてindexするドキュメントの情報を生成する
      def as_indexed_json(*)
        attributes
          .symbolize_keys
          .slice(:id, :title, :auther, :publisher, :series)
      end
    end

    class_methods do
      # ④indexを作成するメソッド
      def create_index!
        client = __elasticsearch__.client
        # すでにindexを作成済みの場合は削除する
        begin
          client.indices.delete index: self.index_name
        rescue StandardError
          nil
        end
        # indexを作成する
        client.indices.create(index: self.index_name,
          body: {
            settings: self.settings.to_hash,
            mappings: self.mappings.to_hash
          })
      end
    end

    def elastic_search(query)
      Book.search({
        query: {
          multi_match: {
            fields:   %w[uuid title auther publisher published_on series page_size],
            type:     'cross_fields',
            query:    query,
            operator: 'and'
          }
        }
      })
    end
  end
end
