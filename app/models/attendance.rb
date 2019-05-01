class Attendance < ApplicationRecord
  belongs_to :user
    validate :started_at_none
    
def started_at_none
    if  worked_on <= Date.today && started_at.nil? 
        errors.add(:finished_at, "退社時間は出勤時間が無いため登録できません。")
    elsif worked_on > Date.today
        errors.add(:finished_at, "退社時間は出勤時間が無いため登録できません。")
    else
    end
end

end