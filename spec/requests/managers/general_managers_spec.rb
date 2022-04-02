require 'rails_helper'

RSpec.describe 'ジェネラルマネージャーのCRUDテスト', type: :request do
  let(:manager) { create(:manager) }
  let(:manager_params) { attributes_for(:manager) }
  let(:invalid_manager_params) { attributes_for(:manager, email: '') }

  before(:each) do
    ActionMailer::Base.deliveries.clear
    login_manager
  end

  describe 'ジェネラルマネージャー新規作成テスト' do
    context 'パラメータが全て揃っている場合' do
      it '新規作成のリクエストが成功すること' do
        post managers_general_managers_path, params: { manager: manager_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        post managers_general_managers_path, params: { manager: manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end

    context 'パラメータが全て揃ってい無い場合' do
      it '新規作成のリクエストが失敗すること' do
        post managers_general_managers_path, params: { manager: invalid_manager_params }
        expect(response.status).to eq 422
      end
    end
  end

  describe 'ジェネラルマネージャー編集テスト' do
    context 'パラメータが全て揃っている場合' do
      it '更新のリクエストが成功すること' do
        patch managers_general_manager_path(manager.id), params: { manager: manager_params }
        expect(response.status).to eq 302
      end

      it '認証メールが送信されること' do
        patch managers_general_manager_path(manager.id), params: { manager: manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 1
      end
    end

    context 'パラメータが揃ってい無い場合' do
      it '更新できずエラーメッセージが出ること' do
        patch managers_general_manager_path(manager.id), params: { manager: invalid_manager_params }
        expect(response.body).to include('エラーが発生したため 管理者 は保存されませんでした。')
        expect(response.status).to eq 422
      end

      it '認証メールが送信されないこと' do
        patch managers_general_manager_path(manager.id), params: { manager: invalid_manager_params }
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end
    end
  end

  describe 'ジェネラルマネージャー削除テスト' do
    let!(:manager) { create(:manager) }

    before(:each) do
      delete managers_general_manager_path(manager.id)
    end

    it 'マネージャーが削除されたこと' do
      expect(Manager.where(id: manager.id).size).to be_zero
    end
  end
end
