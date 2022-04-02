module Users
  class BooksController < Users::Base

    def index
      @books = Book.all
    end

    def show
      @book = Book.find(params[:uuid])
    end
  end
end
