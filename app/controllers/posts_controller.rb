class PostsController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy] 
  
  def index
    if params[:content]
      @posts = Post.where('content LIKE ?', "%#{params[:content]}%").page(params[:page]).per(9)
    else
      @posts = Post.order(id: :desc).page(params[:page]).per(9)
    end
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
  end
  
  def new
    @post = current_user.posts.build
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = '写真を投稿しました。'
      redirect_to posts_url
    else
      flash.now[:danger] = '写真の投稿に失敗しました。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      flash[:success] = "投稿は更新されました"
      redirect_to @post
    else
      flash[:danger] = "投稿は更新されませんでした"
      render :edit
    end  
  end
  
  def destroy
    @post.destroy
    
    flash[:success] = "投稿は削除されました"
    redirect_to posts_url
  end
  
  private

  def post_params
    params.require(:post).permit(:image, :title, :content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end  
  end  
end
