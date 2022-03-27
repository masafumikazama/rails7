require 'rails_helper'

RSpec.describe 'UserSessions', type: :system do
  context 'ユーザー登録ができることを確認' do
    it 'ユーザー登録ができることを確認' do
      visit new_user_registration_path
      fill_in 'user[email]', with: 'user@example.com'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'アカウント登録'
      expect(page).to have_content 'ログイン'
    end
  end

  context 'ログインできることを確認' do
    let!(:user) { FactoryBot.create(:user, password: 'password') }

    it 'ログインできることを確認' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログアウト'
    end
  end
end
