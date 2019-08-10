module AttendancesHelper
  def current_time
    Time.new(
      Time.now.year,
      Time.now.month,
      Time.now.day,
      Time.now.hour,
      Time.now.min, 0
    )
  end
  
  def working_times(started_at, finished_at)
     format("%.2f", (((finished_at - started_at) / 60) / 60.0))
  end
  
  def working_times_sum(seconds)
    format("%.2f", seconds / 60 / 60.0)
  end
  
  def first_day(date)
    !date.nil? ? Date.parse(date) : Date.current.beginning_of_month
  end
  
  def user_attendances_month_date
    @user.attendances.where('worked_on >= ? and worked_on <= ?', @first_day, @last_day).order('worked_on')
  end
  
  def attendances_invaflid?
    attendances = true
    attendances_params.each do |id, item|
      if item[:attendances_started_at].blank? && item[:attendances_finished_at].blank?
        next
      elsif item[:attendances_started_at].blank? || item[:attendances_finished_at].blank?
        attendances = false
        break
      elsif item[:attendances_started_at] > item[:attendances_finished_at] && item[:attendancecheck] == "0"
        attendances = false
        break
      elsif item[:attendances_cheker].blank?
        attendances = false
        break
      end
    end
    return attendances
  end
  def workupdate_invaflid?
    workupdate = true
    workupdate_params.each do |id, item|
      if item[:overworkcheck] == "1" && item[:overconfirmation] == "承認" || item[:overworkcheck] == "1" && item[:overconfirmation] == "否認"
        next
      elsif item[:overworkcheck] == "0"
        workupdate = false
       break
      end
    end
    return workupdate
  end
  
  def attendances_update_invaflid?
    attendances_update = true
    attendancesupdate_params.each do |id, item|
      if item[:attendances_check] == "1"
        next
      elsif item[:attendances_check] == "0"
      attendances_update = false
        break
      end
    end
    return attendances_update
  end
  
  def month_update_invaflid?
    month_update = true
    monthupdate_params.each do |id, item|
    if item[:month_checker].present?
      next
    else
      month_update = false
      break
    end
  end
    return month_update
  end
  
  def month_update_check_invaflid?
    month_update_check = true
     month_update_check_prams.each do |id, item|
       if item[:month_ok_check] == "1"
         next
       elsif item[:month_ok_check] == "0"
         month_update_check = false
         break
       end
    end
    return month_update_check
  end
  
  def working_times2(designated_work_end_time, overworkfinished_at)
     format("%.2f", ((designated_work_end_time - overworkfinished_at)))
  end
end