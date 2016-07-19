class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]


    def index
      @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
        respond_to do |format|
          format.html
          format.json {render json: @posts}
        end
    end

    def new
       @post = Post.new
    end

    def create
      @post = Post.new post_params
      @post.user = current_user
      if @post.save
        redirect_to post_path(@post), notice: "New Post created!"
      else
        flash[:alert] = "Post failed!"
        render :new
      end
    end

    def show
        @post = Post.find(params[:id])
        @user = User.find(post.user_id)
        @comment = Comment.new
        respond_to do |format|
          format.html
          format.json {render json:{post: @post, comments: @post.coments, user: @user}}
        end
    end


    def edit
    end

    def update
        if @post.update post_params
           redirect_to post_path(@post), notice: "Updated!"
        else
            render :edit
        end
    end

    def search
        @string = params[:search]
        @posts = Post.search(@string)
    end


    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private

    def post_params
        params.require(:post).permit(:title, :category_id, :body, {tag_ids: []})
    end

    def find_post
        @post = Post.find params[:id]
    end

end
