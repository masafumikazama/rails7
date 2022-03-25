require 'rails_helper'

describe 'ログイン処理', type: :request do
  let!(:admin) { FactoryBot.create(:admin, password: 'password') }

  describe '管理者がログインできることを確認' do
    it do
      get new_admin_session_path
      expect(response).to have_http_status(:success)
      post admin_session_path, params: { admin: { email: admin.email, password: admin.password } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to 'http://www.example.com/_system_admin_'
    end
  end
end
