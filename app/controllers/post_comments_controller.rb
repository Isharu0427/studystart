class PostCommentsController < ApplicationController
    before_action :authenticate_user!

    def create
      post = Post.find(params[:post_id])
      post_comment = post.post_comments.build(post_comment_params)
      post_comment.user_id = current_user.id
      if post_comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: root_path)
      else
        flash[:success] = "コメントできませんでした"
        redirect_back(fallback_location: root_path)
      end
    end

    private

      def post_comment_params
        params.require(:post_comment).permit(:content, :image)
      end
end