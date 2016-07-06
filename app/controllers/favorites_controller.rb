class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    favorite = current_user.favorites.new
    post = Post.find params[:post_id]
    favorite.post = post
    if favorite.save
      redirect_to post, notice: "Favorited!!"
    else
      redirect_to post, alert: "Can't Favorite!"
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    favorite = current_user.favorites.find params[:id]
    favorite.destroy
    redirect_to post, notice: "Unfavorited!"
  end
end
