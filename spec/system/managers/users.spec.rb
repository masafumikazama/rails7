require 'rails_helper'

RSpec.describe 'マネージャーアカウント内でのユーザー管理テスト', type: :system do
  before(:each) do
    let(:user) { create(:user) }
    login_manager
  end

  context 'ユーザー一覧から詳細までの画面遷移テスト' do
    it 'ユーザー一覧ページに行けることを確認' do
      visit managers_dashboards_path
      click_button 'ユーザー一覧'
      expect(page).to have_content 'ユーザー一覧'
    end

    it 'ユーザー一覧ページから各ユーザーの詳細ページに行けることを確認' do
      visit managers_users_path(user.id)
      click_button '詳細'
      expect(page).to have_content 'ユーザー詳細'
      expect(page).to have_content user.email.to_s
    end
  end
end
