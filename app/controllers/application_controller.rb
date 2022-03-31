# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:email, :role]
    devise_parameter_sanitizer.permit :sign_in, keys: [:email]
  end

  def current_ability
    @current_ability ||= Ability.new(current_manager)
  end
end
