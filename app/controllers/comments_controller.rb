class CommentsController < ApplicationController
    before_action :find_comment, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]


    def index
        @comments = Comment.order(created_at: :desc)

    end

    def new
        @comment = Comment.new

    end

    def create
        @comment = Comment.new comment_params
        @post = Post.find params[:post_id]
        @comment.post = @post
        @comment.user = current_user
        respond_to do |format|
          if @comment.save
            CommentsMailer.notify_comment_owner(@comment).deliver_later unless @comment.user == current_user
            format.html {redirect_to post_path(@post)}
            format.js {render :comment_success}
          else
            format.html {render "posts/show"}
            format.js {render :comment_failure}
          end
        end
    end

    def show

    end

    def edit
    end

    def update

        comment_params = params.require(:comment).permit(:body)

        if @comment.update comment_params
           redirect_to comment_path @comment
        else
            render :edit
        end
    end

    def destroy
        post = Post.find params[:post_id]
        @comment.destroy
        respond_to do |format|
          format.html {redirect_to post_path(post)}
          format.js {render}
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

    def find_comment
        @comment = Comment.find params[:id]
    end
end
