require 'rails_helper'

RSpec.describe 'CSVファイルのインポートテスト', type: :request do
  before(:each) do
    login_manager
  end

  describe 'CSVファイルのインポートテスト' do
    let(:csv_file) { fixture_file_upload(Rails.root.join('spec/files/sample_csv_file.csv'), 'text/csv') }
    let(:blank_csv_file) { fixture_file_upload(Rails.root.join('spec/files/blank_csv_file.csv'), 'text/csv') }
    let(:manager) { create(:manager) }
    let(:book_csv) { create(:book_csv, manager: manager) }
    let(:book_csv_params) { attributes_for(:book_csv) }

    context '有効なCSVファイルをインポートした場合' do
      it 'レスポンスが成功を返すこと' do
        post managers_import_books_path, params: {
          csv_file: fixture_file_upload(csv_file, 'text/csv'),
          book_csv: book_csv_params
        }
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_managers_import_book_path)
      end
    end

    context '無効なCSVファイルをインポートした場合' do
      it 'レスポンスが失敗を返すこと' do
        post managers_import_books_path, params: {
          blank_csv_file: fixture_file_upload(blank_csv_file, 'text/csv'),
          book_csv:       book_csv_params
        }
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_managers_import_book_path)
        # expect(response.body).to include 'インポート失敗'
      end
    end

    context 'ポーリングのエンドポイントテスト' do
      it 'ポーリングのエンドポイントテストが成功すること' do
        get "/managers/book_csv/#{book_csv.id}/status", params: { book_csv: book_csv_params, format: :json, xhr: true }
        expect(response.status).to eq(200)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['status']).to eq('完了')
      end
    end
  end
end
