require 'rails_helper'

RSpec.describe '図書データのCRUD画面遷移', type: :system do
  let(:book) { create(:book) }

  before(:each) do
    login_manager
  end

  context '図書データのCRUD画面遷移' do
    it '図書データを新規作成できることを確認' do
      visit new_managers_book_path
      fill_in 'book[title]', with: 'サンプルタイトル'
      fill_in 'book[auther]', with: 'サンプル著者'
      fill_in 'book[publisher]', with: 'サンプル出版'
      find('#book_published_on_1i').find("option[value='2022']").select_option
      find('#book_published_on_2i').find("option[value='1']").select_option
      find('#book_published_on_3i').find("option[value='1']").select_option
      fill_in 'book[series]', with: 'サンプルシリーズ'
      fill_in 'book[page_size]', with: '100'
      click_button '登録する'
      expect(page).to have_content '図書データ詳細'
    end

    it '図書データを編集できることを確認' do
      visit edit_managers_book_path(book)
      fill_in 'book[title]', with: 'サンプルタイトル'
      fill_in 'book[auther]', with: 'サンプル著者'
      fill_in 'book[publisher]', with: 'サンプル出版'
      find('#book_published_on_1i').find("option[value='2022']").select_option
      find('#book_published_on_2i').find("option[value='1']").select_option
      find('#book_published_on_3i').find("option[value='1']").select_option
      fill_in 'book[series]', with: 'サンプルシリーズ'
      fill_in 'book[page_size]', with: '100'
      click_button '更新する'
      expect(page).to have_content '図書データ詳細'
    end

    it '図書データを削除できることを確認' do
      visit managers_book_path(book)
      click_link '図書データを削除する'
      expect(page.accept_confirm).to eq '削除してもよろしいですか?'
      expect(page).to have_content '図書データ一覧'
    end
  end
end
