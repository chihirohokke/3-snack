class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_back(fallback_location: post_path(post.id))
    else
      flash[:success] = "コメントできませんでした"
      redirect_back(fallback_location: post_path(post.id))
    end  
  end

  
  def destroy
    post = Post.find(params[:post_id])
    @comment.destroy
    flash[:success] = '投稿へのコメントを削除しました。'
    redirect_back(fallback_location: post_path(post.id))
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
