class AttendancesController < ApplicationController
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
            flash[:success] =  "勤怠情報を更新しました。"
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
      flash[:success] = "残業申請をしました。"
      redirect_to @user
    else
      flash[:danger] = "残業申請できませんでした。再度やり直してください。"
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
      flash[:danger] = "残業申請の変更ができませんでした。再度やり直してください。"
      redirect_to @user
    end
  end
    private
    
    def attendances_params
        params.permit(attendances: [:started_at, :finished_at, :note, :overtime, :instruction])[:attendances]
    end
    
    def overwork_params
      params.require(:attendance).permit(:overworkfinished_at, :overwork_note, :overcheck, :overcheker)
    end
    
    def workupdate_params
      params.permit(attendances: [:overworkcheck, :overconfirmation])[:attendances]
    end
end
