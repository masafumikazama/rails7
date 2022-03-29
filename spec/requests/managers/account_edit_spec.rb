require 'rails_helper'

RSpec.describe 'マネージャーアカウントの編集テスト', type: :request do
  let(:manager) { create(:manager) }
  let(:manager_params) { attributes_for(:manager) }
  let(:invalid_manager_params) { attributes_for(:manager, email: '') }

  describe 'マネージャーアカウントの編集テスト' do
    before(:each) do
      ActionMailer::Base.deliveries.clear
      login_manager
    end

    context 'マネージャー詳細編集のパラメータが全て揃っている場合' do
      it '更新のリクエストが成功すること' do
        patch managers_update_path, params: { manager: manager_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        patch managers_update_path, params: { manager: manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'リダイレクトされること' do
        patch managers_update_path, params: { manager: manager_params }
        expect(response).to redirect_to managers_show_path
      end
    end

    context 'マネージャー詳細編集のパラメータが揃ってい無い場合' do
      it '更新は失敗するがリクエスト自体はエラーにならないこと' do
        patch managers_update_path, params: { manager: invalid_manager_params }
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        patch managers_update_path, params: { manager: invalid_manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end
    end
  end
end
