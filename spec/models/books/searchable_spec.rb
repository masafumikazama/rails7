require 'rails_helper'

RSpec.describe 'Elasticsearchの全文検索テスト', elasticsearch: true do

  describe '.Elasticsearchの全文検索テスト' do
    describe '検索にマッチする図書データの検索' do
      let!(:book_1) do
        create(:book, uuid: "27b84b0d-0ce5-4b23-81f3-736f808e89c2", title: '河童', auther: "菅原翔", publisher: "勉誠出版", published_on: '2022-04-01', series: "歴史", page_size: 421)
      end
      let!(:book_2) do
        create(:book, uuid: "2549dc87-5b13-494c-abd0-ec0f7a872f44", title: '阿部一族', auther: "田中優", publisher: "第一法規", published_on: '2022-04-02', series: "歴史・時代小説", page_size: 841)
      end
      let!(:book_3) do
        create(:book, uuid: "247c6698-0bc1-41d4-a969-d4bc5c713b7b", title: '或恋愛小説', auther: '田村優斗', publisher: "金剛出版", published_on: '2022-04-03', series: "イラスト・デザイン", page_size: 831)
      end

      before :each do
        # 作成したデータをelasticsearchに登録する
        Book.__elasticsearch__.import(refresh: true)
      end

      def search_book_uuid
        Book.new.elastic_search(query).records.pluck(:uuid)
      end

      context '検索ワードがタイトルにマッチする場合' do
        let(:query) { '河童' }

        it '検索ワードにマッチする図書データを取得する' do
          expect(search_book_uuid).to eq [book_1.uuid]
        end
      end

      context '検索ワードが著者にマッチする場合' do
        let(:query) { '田村優斗' }

        it '検索ワードにマッチする図書データを取得する' do
          expect(search_book_uuid).to eq [book_3.uuid]
        end
      end

      context '検索ワードがシリーズにマッチする場合' do
        let(:query) { 'イラスト・デザイン' }

        it '検索ワードにマッチする図書データを取得する' do
          expect(search_book_uuid).to eq [book_3.uuid]
        end
      end

      context '検索ワードが出版社にマッチする場合' do
        let(:query) { '第一法規' }

        it '検索ワードにマッチする図書データを取得する' do
          expect(search_book_uuid).to eq [book_2.uuid]
        end
      end
    end
  end
end
