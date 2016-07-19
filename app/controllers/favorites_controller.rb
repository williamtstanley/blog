class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.new
    @post = Post.find params[:post_id]
    @favorite.post = @post
    @favorite.save
    respond_to do |format|
      format.html {redirect_to @post}
      format.js {render :favorite}
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_user.favorites.find params[:id]
    @favorite.destroy
    respond_to do |format|
      format.html {redirect_to @post}
      format.js {render :favorite}
    end
  end
end
