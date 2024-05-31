class BooksController < ApplicationController
  before_action :authenticate_user!
    def index
      if params[:search] != nil && params[:search] != ''
        search = params[:search]
        @books = Book.joins(:user).where("title LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%")
      else
        @books = Book.all
      end

      @books = @books.page(params[:page]).per(3)
    end


    def new
        @book = Book.new
    end

    def create
        book = Book.new(book_params)

        book.user_id = current_user.id

        if book.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
      @book = Book.find(params[:id])
      @book_comments = @book.book_comments
      @book_comment = BookComment.new
    end

    def edit
      @book = Book.find(params[:id])
    end

    def update
      book = Book.find(params[:id])
      if book.update(book_params)
        redirect_to :action => "show", :id => book.id
      else
        redirect_to :action => "new"
      end
    end

    def destroy
      book = Book.find(params[:id])
      book.destroy
      redirect_to action: :index
    end

    private
  def book_params
    params.require(:book).permit(:title,:publisher,:genre,:about,:user_id,:date_publication,:grade,:image)
  end
end
