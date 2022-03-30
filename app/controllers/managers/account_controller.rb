# frozen_string_literal: true

module Managers
  # 管理者のアカウント
  class AccountController < Managers::Base
    def show; end

    def edit; end

    def update
      if current_manager.update(manager_params)
        sign_in(current_manager, bypass: true)
        redirect_to managers_show_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private
    def manager_params
      params.require(:manager).permit(:email, :password, :password_confirmation)
    end
  end
end
