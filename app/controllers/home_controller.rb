class HomeController < ApplicationController
    def index
        @posts = Post.order(created_at: :desc).page(params[:page]).per(10)
    end
    def about
    end
end
