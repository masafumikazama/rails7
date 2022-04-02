# frozen_string_literal: true

module Managers
  # 管理者のアカウント
  class GeneralManagersController < Managers::Base
    before_action :set_manager, only: %i[show edit update destroy]

    def index
      @managers = Manager.all
    end

    def show; end

    def new
      @manager = Manager.new
    end

    def create
      @manager = Manager.new(manager_params)
      if @manager.save
        sign_in(current_manager, bypass: true)
        redirect_to managers_general_manager_path(@manager)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @manager.update(manager_params)
        sign_in(current_manager, bypass: true)
        redirect_to managers_general_manager_path(@manager)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @manager.destroy
        sign_in(current_manager, bypass: true)
        redirect_to managers_general_managers_path, status: :see_other
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def set_manager
      @manager = Manager.find(params[:id])
    end

    def manager_params
      params.require(:manager).permit(:email, :password, :password_confirmation)
    end
  end
end
