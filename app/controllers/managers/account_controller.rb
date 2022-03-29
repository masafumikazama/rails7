# frozen_string_literal: true

module Managers
  # 管理者のアカウント
  class AccountController < Managers::Base
    before_action :set_manager, only: %i[show edit update]

    def show

    end

    def edit


    end

    def update
      if @manager.update(manager_params)
        sign_in(@manager, :bypass=>true)
        redirect_to managers_show_path
      else
        render :edit
      end
    end

    def manager_params
      params.require(:manager).permit(:email, :password, :password_confirmation)
    end

    private

      def set_manager
        @manager = current_manager
      end
  end
end
