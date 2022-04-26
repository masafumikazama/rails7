require 'rails_helper'

RSpec.describe 'CSVファイルのインポートテスト', type: :request do

  before(:each) do
    login_manager
  end

  describe 'CSVファイルのインポートテスト' do
    let(:json_response) { JSON.parse(response.body) }

    context '有効なCSVファイルをインポートした場合' do
      let(:csv_file) { fixture_file_upload(Rails.root.join('spec/files/sample_csv_file.csv'), 'text/csv') }
      let(:book) do
        csv_headers = %w[uuid title auther Publisher published_on series page_size]
        book_attributes_list = [
          %w[27b84b0d-0ce5-4b23-81f3-736f808e89a1 テストタイトル1 テスト著者1 テスト出版1 2022-04-01 歴史 100],
          %w[27b84b0d-0ce5-4b23-81f3-736f808e89a2 テストタイトル2 テスト著者2 テスト出版2 2022-04-01 歴史 200]
        ]
        book_import_source = build(:book_import_source,
                                       csv_headers: csv_headers,
                                       book_attributes_list: book_attributes_list)
        create(:book, book_import_source: book_import_source)
      end

      before do
        allow(Book).to receive(:create_from_csv).and_return(book)
        post managers_import_books_path, params: { file: csv_file }, xhr: true
      end

      it 'ステータスコード 200 を返すこと' do
        expect(response).to have_http_status(:ok)
      end

      it 'リダイレクトURLの情報を含むjsonを返すこと' do
        expect(json_response).to have_key('redirect_url')
      end

      it 'リダイレクト画面のURLと一致すること' do
        expect(json_response['redirect_url']).to eq(new_managers_import_book_path)
      end
    end
  end
end
