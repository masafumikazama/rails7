# frozen_string_literal: true

module Managers
  class ImportBooksController < Managers::Base
    def new; end

    def create
      Book.import(params[:file])
      sign_in(current_manager, bypass: true)
      redirect_to managers_books_path
    end
  end
end
