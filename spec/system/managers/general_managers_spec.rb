require 'rails_helper'

RSpec.describe 'ジェネラルマネージャーのCRUD画面遷移', type: :system do
  let(:manager) { create(:manager) }

  before(:each) do
    login_manager
  end

  context 'ジェネラルマネージャーのCRUD画面遷移' do
    it 'ジェネラルマネージャーを新規作成できることを確認' do
      visit new_managers_general_manager_path
      fill_in 'manager[email]', with: 'manager@example.com'
      fill_in 'manager[password]', with: 'password'
      fill_in 'manager[password_confirmation]', with: 'password'
      click_button '登録する'
      expect(page).to have_content 'マネージャー詳細'
    end

    it 'ジェネラルマネージャーを編集できることを確認' do
      visit edit_managers_general_manager_path(manager.id)
      fill_in 'manager[email]', with: 'manager@example.com'
      fill_in 'manager[password]', with: 'password'
      fill_in 'manager[password_confirmation]', with: 'password'
      click_button '更新する'
      expect(page).to have_content 'マネージャー詳細'
    end

    it 'ジェネラルマネージャーを削除できることを確認' do
      visit managers_general_manager_path(manager.id)
      click_link 'アカウントを削除する'
      expect(page.accept_confirm).to eq '削除してもよろしいですか?'
      expect(page).to have_content 'マネージャー一覧'
    end
  end
end
