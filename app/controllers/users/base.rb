# frozen_string_literal: true

module Users
  class Base < ApplicationController
    layout 'user'
    before_action :authenticate_user!
  end
end
