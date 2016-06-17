class PostsController < ApplicationController
    before_action :find_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]
    def index
        @string = params[:search]
        @posts = Post.order(created_at: :desc).search(@string).page(params[:page]).per(7)

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
        @comment = Comment.new
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
        params.require(:post).permit(:title, :category_id, :body)
    end

    def find_post
        @post = Post.find params[:id]
    end


end
