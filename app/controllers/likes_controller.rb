class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.sweet(post)
    flash[:success] = '投稿にSweetしました。'
    # redirect_to root_url
    redirect_back(fallback_location: posts_path)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.notsweet(post)
    flash[:success] = '投稿のSweetを解除しました。'
    # redirect_to root_url
    redirect_back(fallback_location: posts_path)
  end
end
