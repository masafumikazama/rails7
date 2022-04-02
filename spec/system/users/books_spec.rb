require 'rails_helper'

RSpec.describe 'ユーザー図書データの画面遷移', type: :system do
  let!(:book) { create(:book) }

  before(:each) do
    login_user
  end

  context '図書データの画面遷移' do
    it '図書データの一覧が見れることを確認' do
      visit users_dashboards_path
      click_link '図書データ一覧'
      expect(page).to have_content '図書データ一覧'
      expect(page).to have_content book.uuid
      expect(page).to have_content book.title
      expect(page).to have_content book.auther
    end

    it '図書データの詳細が見れることを確認' do
      visit users_book_path(book)
      expect(page).to have_content '図書データ詳細'
      expect(page).to have_content book.uuid
      expect(page).to have_content book.title
      expect(page).to have_content book.auther
    end
  end
end
