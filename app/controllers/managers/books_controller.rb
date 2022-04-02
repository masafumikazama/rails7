module Managers
  class BooksController < Managers::Base
    before_action :set_book, only: %i[show edit update destroy]

    def index
      @books = Book.all
    end

    def show; end

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        sign_in(current_manager, bypass: true)
        redirect_to managers_book_path(@book)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @book.update(book_params)
        sign_in(current_manager, bypass: true)
        redirect_to managers_book_path(@book)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @book.destroy
        sign_in(current_manager, bypass: true)
        redirect_to managers_books_path, status: :see_other
      else
        render :show, status: :unprocessable_entity
      end
    end

    private

    def set_book
      @book = Book.find(params[:uuid])
    end

    def book_params
      params.require(:book).permit(:title, :auther, :publisher, :published_on, :series, :page_size)
    end
  end
end
