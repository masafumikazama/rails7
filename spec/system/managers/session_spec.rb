require 'rails_helper'

RSpec.describe 'ManagerSessions', type: :system do
  context 'マネージャー登録ができることを確認' do
    it 'マネージャー登録ができることを確認' do
      visit new_manager_registration_path
      fill_in 'manager[email]', with: 'manager@example.com'
      fill_in 'manager[password]', with: 'password'
      fill_in 'manager[password_confirmation]', with: 'password'
      click_button 'アカウント登録'
      expect(page).to have_content 'ログイン'
    end
  end

  context 'ログインできることを確認' do
    let!(:manager) { FactoryBot.create(:manager, password: 'password') }

    it 'ログインできることを確認' do
      visit new_manager_session_path
      fill_in 'manager[email]', with: manager.email
      fill_in 'manager[password]', with: manager.password
      click_button 'ログイン'
      expect(page).to have_content 'ログアウト'
    end
  end
end
