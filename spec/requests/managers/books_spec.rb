require 'rails_helper'

RSpec.describe '図書データのCRUDテスト', type: :request do
  let(:book) { create(:book) }
  let(:book_params) { attributes_for(:book) }
  let(:invalid_book_params) { attributes_for(:book, title: Faker::Lorem.characters(number: 31)) }

  before(:each) do
    ActionMailer::Base.deliveries.clear
    login_manager
  end

  describe '図書データ新規作成テスト' do
    context 'パラメータが全て揃っている場合' do
      it '新規作成のリクエストが成功すること' do
        post managers_books_path, params: { book: book_params }
        expect(response.status).to eq 302
      end
    end

    context 'パラメータが全て揃っていない場合' do
      it '新規作成が失敗すること' do
        post managers_books_path, params: { book: invalid_book_params }
        expect(response.status).to eq 422
      end
    end
  end

  describe '図書データ編集テスト' do
    context 'パラメータが全て揃っている場合' do
      it '更新のリクエストが成功すること' do
        patch managers_book_path(book), params: { book: book_params }
        expect(response.status).to eq 302
      end
    end

    context 'パラメータが揃っていない場合' do
      it '更新ができないこと' do
        patch managers_book_path(book), params: { book: invalid_book_params }
        expect(response.status).to eq 422
      end
    end
  end

  describe '図書データ削除テスト' do
    let!(:book) { create(:book) }

    before(:each) do
      delete managers_book_path(book)
    end

    it '図書データが削除されたこと' do
      expect(Book.where(uuid: book.uuid).size).to be_zero
    end
  end
end
