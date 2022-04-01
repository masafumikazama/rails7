require 'rails_helper'

RSpec.describe 'マネージャー登録から認証メールの送信テスト', type: :request do
  let(:manager) { create(:manager) }
  let(:manager_params) { attributes_for(:manager) }
  let(:invalid_manager_params) { attributes_for(:manager, email: '') }

  describe 'マネージャー登録から認証メールの送信テスト' do
    before(:each) do
      ActionMailer::Base.deliveries.clear
    end

    context 'マネージャー登録のパラメータが全て揃っている場合' do
      it 'リクエストが成功すること' do
        post manager_registration_path, params: { manager: manager_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        post manager_registration_path, params: { manager: manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'createが成功すること' do
        expect {
          post manager_registration_path, params: { manager: manager_params }
        }.to change(Manager, :count).by 1
      end

      it 'リダイレクトされること' do
        post manager_registration_path, params: { manager: manager_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'マネージャー登録のパラメータが不正な場合' do
      it '登録はされないがリクエスト自体はエラーにならないこと' do
        post manager_registration_path, params: { manager: invalid_manager_params }
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        post manager_registration_path, params: { manager: invalid_manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it '登録が失敗すること' do
        expect {
          post manager_registration_path, params: { manager: invalid_manager_params }
        }.not_to change(Manager, :count)
      end
    end

    context 'Adminマネージャーが登録済みな場合' do
      let!(:manager) { create(:manager) }

      it 'リダイレクトされること' do
        post manager_registration_path, params: { manager: manager_params }
        expect(response.status).to eq 302
      end

      it '登録されないこと' do
        expect {
          post manager_registration_path, params: { manager: manager_params }
        }.not_to change(Manager, :count)
      end
    end
  end
end
