require 'rails_helper'

RSpec.describe 'Adminマネージャー登録', type: :system do
  context 'Adminマネージャー登録ができることを確認' do
    it 'Adminマネージャー登録ができることを確認' do
      visit new_manager_registration_path
      fill_in 'manager[email]', with: 'manager@example.com'
      fill_in 'manager[password]', with: 'password'
      fill_in 'manager[password_confirmation]', with: 'password'
      click_button 'アカウント登録'
      expect(page).to have_content 'ログイン'
    end
  end

  context 'Adminマネージャーを登録後、再登録できないことを確認' do
    let!(:manager) { create(:manager) }

    it '登録画面にフォームが存在指定なことを確認' do
      visit new_manager_registration_path
      expect(page).to have_content 'admin権限のマネージャーが既に存在しています。'
    end
  end
end
