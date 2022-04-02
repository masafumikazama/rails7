require 'rails_helper'

RSpec.describe 'Bookモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject do
      book
    end

    let!(:book) { create(:book) }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    context 'titleカラム' do
      it '空欄でないこと' do
        book.title = ''
        expect(book).to be_invalid
        expect(book.errors[:title]).to include('を入力してください')
      end

      it '31文字以上は通らないこと' do # TODO: Faker::Lorem.characters(number:31) gem faker を使っても良いか相談。
        book.title = Faker::Lorem.characters(number: 31)
        expect(book.valid?).to eq false
      end

      it '30文字以下は通ること' do
        book.title = Faker::Lorem.characters(number: 30)
        expect(book.valid?).to eq true
      end
    end

    context 'page_sizeカラム' do
      it '空欄でないこと' do
        book.page_size = ''
        expect(book).to be_invalid
        expect(book.errors[:page_size]).to include('を入力してください')
      end
    end

    context 'uuidカラム' do
      it '空欄でないこと' do
        book.uuid = ''
        expect(book).to be_invalid
        expect(book.errors[:uuid]).to include('を入力してください')
      end
    end
  end
end
