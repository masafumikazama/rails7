# frozen_string_literal: true

# アプリケーション共通のヘルパ
module ApplicationHelper
  def exit_admin_manager
    Manager.exists?(role: 'admin')
  end
end
