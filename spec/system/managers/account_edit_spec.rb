require 'rails_helper'

RSpec.describe 'マネージャー詳細の更新', type: :system do
  before(:each) do
    login_manager
  end

  context 'マネージャー詳細の更新' do
    it '全てのパラメータが入ると詳細の更新が成功することを確認' do
      visit managers_edit_path
      fill_in 'manager[email]', with: 'manager@example.com'
      fill_in 'manager[password]', with: 'password'
      fill_in 'manager[password_confirmation]', with: 'password'
      click_button '更新する'
      expect(page).to have_content 'アカウント詳細'
    end

    it 'パラメータが入っていないと詳細の更新が失敗することを確認' do
      visit managers_edit_path
      fill_in 'manager[email]', with: ''
      fill_in 'manager[password]', with: ''
      fill_in 'manager[password_confirmation]', with: ''
      click_button '更新する'
      expect(page).to have_content 'アカウント編集'
    end
  end
end
