require 'rails_helper'

RSpec.describe 'ユーザー登録から認証メールの送信テスト', type: :request do
  let(:user) { create(:user) }
  let(:user_params) { attributes_for(:user) }
  let(:invalid_user_params) { attributes_for(:user, email: '') }

  describe 'ユーザー登録から認証メールの送信テスト' do
    before(:each) do
      ActionMailer::Base.deliveries.clear
    end

    context 'ユーザー登録のパラメータが全て揃っている場合' do
      it 'リクエストが成功すること' do
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        post user_registration_path, params: { user: user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end

      it 'createが成功すること' do
        expect {
          post user_registration_path, params: { user: user_params }
        }.to change(User, :count).by 1
      end

      it 'リダイレクトされること' do
        post user_registration_path, params: { user: user_params }
        expect(response).to redirect_to root_url
      end
    end

    context 'ユーザー登録のパラメータが不正な場合' do
      it '登録はされないがリクエスト自体はエラーにならないこと' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(response.status).to eq 200
      end

      it '認証メールが送信されないこと' do
        post user_registration_path, params: { user: invalid_user_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end

      it '登録が失敗すること' do
        expect {
          post user_registration_path, params: { user: invalid_user_params }
        }.not_to change(User, :count)
      end
    end
  end
end
