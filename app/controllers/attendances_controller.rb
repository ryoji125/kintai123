class AttendancesController < ApplicationController
  before_action :no_admin_user,  only: [:edit]
    def create
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
        if @attendance.started_at.nil?
            @attendance.update_attributes(started_at: current_time)
            flash[:info]="おはようございます。"
        elsif
            @attendance.update_attributes(finished_at: current_time)
            flash[:info]="お疲れさまでした。"
        else
            flash[:danger]="トラブルがあり、登録できませんでした。"
        end
        redirect_to @user
    end
    def edit 
     @user = User.find(params[:id])
        if @user == current_user || current_user.admin?
            @first_day = first_day(params[:date])
            @last_day = @first_day.end_of_month
            @dates = user_attendances_month_date
        else
           redirect_to root_url
        end 
    end
    
    def update
        @user = User.find(params[:id])
        @attendance = @user.attendances.find_by(worked_on: Date.today)
        if attendances_invaflid?
            attendances_params.each do |id, item|
                attendance = Attendance.find(id)
                attendance.update_attributes(item)
        end
            flash[:success] =  "勤怠情報の更新を申請しました。"
            redirect_to user_path(@user, params:{first_day: params[:date]})
        else
            flash[:danger] = "不正な時間入力がありました、再入力してください。"
            redirect_to edit_attendances_path(@user, params[:date])
        end
    end
  def edit_overwork
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find(params[:id])
  end
  
  def update_overwork
    @user = User.find(params[:user_id])
    @attendance = @user.attendances.find(params[:id])
    if @attendance.update_attributes(overwork_params)
      @attendance.update_attributes(overcheck: nil)
      flash[:success] = "残業申請をしました。"
      redirect_to @user
    else
      flash[:danger] = "残業申請できませんでした、再度やり直してください。"
      redirect_to @user
    end
  end
  
  def edit_work
    @user = User.find(params[:id])
    @users = User.all
    
  end
  
  def update_work
    @user = User.find(params[:id])
    if workupdate_invaflid?
      workupdate_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes(item)
      end
      flash[:success] = "残業申請の変更を送信しました。"
      redirect_to @user
    else
      flash[:danger] = "残業申請の変更ができませんでした、再度やり直してください。"
      redirect_to @user
    end
  end
  
  def attendances_edit
    @user = User.find(params[:id])
    @users = User.all
  end
  
  def attendances_update
    @user = User.find(params[:id])
    if attendances_update_invaflid?
      attendancesupdate_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes(item)
      end
      flash[:success] = "勤怠変更申請の変更を送信しました。"
      redirect_to @user
    else
      flash[:danger] = "勤怠変更申請の変更ができませんでした、再度やり直してください。"
      redirect_to @user
    end
  end
  
  def month_attendances_update
    @user = User.find(params[:id])
    if month_update_invaflid?
      monthupdate_params.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes(item)
      end
      flash[:success] = "一ヶ月申請をしました。"
      redirect_to @user
    else
      flash[:danger] = "申請の変更に失敗しました。再度やり直してください。"
      redirect_to @user
    end
  end
  
  def month_attendances_update_check_edit
    @user = User.find(params[:id])
    @users = User.all
  end
  
  def month_attendances_update_check_update
    @user = User.find(params[:id])
    if month_update_check_invaflid?
      month_update_check_prams.each do |id, item|
        attendance = Attendance.find(id)
        attendance.update_attributes(item)
      end
      flash[:success] = "一ヶ月承認の申請の変更を送信しました。"
      redirect_to @user
    else
      flash[:danger] = "申請の変更に失敗しました。再度やり直してください。"
      redirect_to @user
    end
  end
  
  def attendances_log
    @user = User.find(params[:id])
    @first_day = first_day(params[:date])
    @last_day = @first_day.end_of_month
    @dates = user_attendances_month_date
  end
    private
    
    def attendances_params
      params.permit(attendances: [:attendances_started_at, :attendances_finished_at, :attendances_note, :attendancecheck, :attendances_cheker])[:attendances]
    end
    
    def overwork_params
      params.require(:attendance).permit(:overworkfinished_at, :overwork_note, :overcheck, :overcheker)
    end
    
    def workupdate_params
      params.permit(attendances: [:overworkcheck, :overconfirmation])[:attendances]
    end
    
    def attendancesupdate_params
      params.permit(attendances: [:attendances_confirmation, :attendances_check])[:attendances]
    end
    
    def monthupdate_params
      params.permit(attendances: [:month_checker, :month_ok_check])[:attendances]
    end
    
    def month_update_check_prams
      params.permit(attendances: [:month_confirmation, :month_ok_check])[:attendances]
    end
    
    def no_admin_user
      redirect_to(root_url) if current_user.admin?
    end
end
