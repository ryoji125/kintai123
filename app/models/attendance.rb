class Attendance < ApplicationRecord
  belongs_to :user
    validate :started_at_none
    
def started_at_none
    if  started_at.nil? 
        errors.add(:finished_at, "退社時間は出勤時間が無いため登録できません。")
    end
end

end