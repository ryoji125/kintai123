class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page]) 
  end
  
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new # 新規作成されたUserオブジェクトをインスタンス変数に代入します
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "アカウントを作成しました。"
      redirect_to @user
    else
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "更新に成功しました"
      redirect_to @user
    else
      render "edit"
    end
  end
  
    private
    
    def user_params
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    #beforeフィルター
    
    def logged_in_user
      unless logged_in?
      flash[:danger] = "ログインしてください。"
      redirect_to login_path
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless @user == current_user
    end
    
    def destroy
    User.find(params[:id]).destroy
    flash[:success] = "削除しました"
    redirect_to users_path
    end
end
