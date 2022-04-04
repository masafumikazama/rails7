# frozen_string_literal: true

module Managers
  class ImportBooksController < Managers::Base
    def new; end

    def create
      Book.import(params[:file])
      redirect_to root_path
    end
  end
end
