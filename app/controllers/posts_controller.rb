class PostsController < ApplicationController
  before_action :authenticate_user!
    def index
      if params[:search] != nil && params[:search] != ''
        search = params[:search]
        @posts = Post.joins(:user).where("body LIKE ? OR name LIKE ?", "%#{search}%", "%#{search}%")
      else
        @posts = Post.all
        @posts = Post.all.order(created_at: :desc)
      end

      @posts = @posts.page(params[:page]).per(3)
      @rank_posts = Post.all.sort {|a,b| b.post_liked_users.count <=> a.post_liked_users.count}.first(3)
    end

    def new
        @post = Post.new
    end

    def create
        post = Post.new(post_params)

        post.user_id = current_user.id

        if post.save
          redirect_to :action => "index"
        else
          redirect_to :action => "new"
        end
    end

    def show
        @post = Post.find(params[:id])
        @post_comments = @post.post_comments
        @post_comment = PostComment.new
    end

    def edit
        @post = Post.find(params[:id])
        @post_comments = @post.post_comments
        @post_comment = PostComment.new
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
          redirect_to :action => "show", :id => post.id
        else
          redirect_to :action => "new"
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
    end

    private
    def post_params
        params.require(:post).permit(:body,:genre,:image)
    end

end
