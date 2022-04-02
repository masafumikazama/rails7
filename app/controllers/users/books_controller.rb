module Users
  class BooksController < Users::Base

    def index
      @books = Book.page(params[:page]).per(10)
    end

    def show
      @book = Book.find(params[:uuid])
    end
  end
end
