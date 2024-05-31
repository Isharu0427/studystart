class BookCommentsController < ApplicationController
    before_action :authenticate_user!

    def create
      book = Book.find(params[:book_id])
      book_comment = book.book_comments.build(book_comment_params)
      book_comment.user_id = current_user.id
      if book_comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end

    private

      def book_comment_params
        params.require(:book_comment).permit(:content, :image)
      end
end
