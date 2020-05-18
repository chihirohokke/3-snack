class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :sweets, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :sweets, :edit, :update, :destroy, :followings, :followers]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(20)
  end

  def show
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    unless @user == current_user
      redirect_to root_url
    end
  end
  
  def update

    #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
    if current_user == @user
 
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        redirect_to @user
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end   
    else
      redirect_to root_url
    end
  end
  
  def destroy
    if current_user == @user
      @user.destroy
      flash[:success] = 'ユーザーを削除しました。'
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  
  def sweets
    @sweets = @user.sweets.page(params[:page])
    counts(@user)
  end
  
  def followings
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :image)
  end
  
  def set_user
    @user = User.find_by(id: params[:id])
  end
end
