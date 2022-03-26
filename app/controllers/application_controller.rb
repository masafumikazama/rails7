# frozen_string_literal: true

class ApplicationController < ActionController::Base # rubocop:disable Style/Documentation
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:email]
    devise_parameter_sanitizer.permit :sign_in, keys: [:email]
  end
end
