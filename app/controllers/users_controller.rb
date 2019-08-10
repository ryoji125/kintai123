class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: [:destroy, :edit_basic_info, :update_basic_info, :index, :go_work, :basic_information]
  before_action :no_admin_user,  only: [:show]
  require 'rounding'
  
  def index
    @user = User.find_by(params[:id])
    @users = User.paginate(page: params[:page]).order(id: :asc)
    if params[:name].present?
    @users = @users.get_by_name params[:name]
    end
  end
  
  def import
    # fileはtmpに自動で一時保存される
    User.import(params[:file])
    flash[:success] = "ユーザー情報をインポートしました。"
    redirect_to users_url
  end
  
  def show
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
      if @user == current_user || current_user.superior?
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
      @attendances_month = @user.attendances.find_by(worked_on: @first_day.to_s)
      else
      redirect_to root_url
      end
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "勤務情報.csv", type: :csv
      end
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
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params) || admin_user
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
  
  def go_work
  @now_users = []
  @now_users_employee_number = []
    User.all.each do |user|
    if user.attendances.
      any?{|day|
       ( day.worked_on == Date.today &&
         !day.started_at.blank? &&
         day.finished_at.blank? )
        }
     @now_users.push(user.name)
     @now_users_employee_number.push(user.employee_number)
    end
   end
   @now_user = [@now_users, @now_users_employee_number].transpose
  end
#「出社」をクリックすると、「@now_users」の配列にユーザー名が格納される。
  def edit_basic_info
    @user = User.find(params[:id])
  end
  
  def update_basic_info
    @user = User.find(params[:id])
    if @user.update_attributes(basic_info_params) || admin_user
      flash[:success] = "更新に成功しました"
      redirect_to @user
    else
      render "edit_basic_info"
    end
  end
  
  def basic_information
    
  end
    private
    
    def user_params
      params.require(:user).permit(:name,:email,:affiliation,:password,:password_confirmation,:uid,:work_time,:designated_work_start_time,:designated_work_end_time)
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
      redirect_to(root_path) unless @user == current_user || current_user.admin?
    end
  
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def no_admin_user
      redirect_to(root_url) if current_user.admin?
    end
end
