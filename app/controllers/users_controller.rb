class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :edit_basic_info, :update_basic_info, :index]
  require 'rounding'
  
  def index
    @user = User.find(1)
     @users = User. paginate(page: params[:page])
    if params[:name].present?
    @users = @users.get_by_name params[:name]
    end
  end
  
  def show
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
    if @user == current_user || current_user.admin?
    @first_day = first_day(params[:first_day])
      @last_day = @first_day.end_of_month
      (@first_day..@last_day).each do |day|
        unless @user.attendances.any? {|attendance| attendance.worked_on == day}
      record = @user.attendances.build(worked_on: day)
      record.save
        end
      end
    @dates = user_attendances_month_date
    @worked_sum = @dates.where.not(started_at: nil).count
    else
    redirect_to root_url
    end
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
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "削除しました"
      redirect_to users_path
    end
  
  def edit_basic_info
    @user = User.find(params[:id])
  end
  
  def update_basic_info
    @user = User.find(params[:id])
    if @user.update_attributes(basic_info_params)
      flash[:success] = "更新に成功しました"
      redirect_to @user
    else
      render "edit_basic_info"
    end
  end
  
    private
    
    def user_params
      params.require(:user).permit(:name,:email,:department,:password,:password_confirmation)
    end
    
    def basic_info_params
      params.require(:user).permit(:work_time, :basic_time)
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
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
