class RelationshipsController < ApplicationController
  before_action :require_user_logged_in

  def create
    @user = User.find(params[:follow_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:follow_id])
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end
