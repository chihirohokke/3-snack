class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @post = Post.find(params[:post_id])
    unless current_user.like?(@post)
      current_user.sweet(@post)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end    
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    if current_user.like?(@post)
      current_user.notsweet(@post)
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
