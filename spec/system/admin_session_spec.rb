require 'rails_helper'

RSpec.describe 'AdminSessions', type: :system do
  context 'ログインできることを確認' do
    let!(:admin) { FactoryBot.create(:admin, password: 'password') }

    it 'ログインできることを確認' do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      expect(page).to have_content 'ログアウト'
    end
  end
end
