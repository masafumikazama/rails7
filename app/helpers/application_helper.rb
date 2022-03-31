# frozen_string_literal: true

# アプリケーション共通のヘルパ
module ApplicationHelper
  def admin_manager_exists?
    Manager.exists?(role: 'admin')
  end
end
