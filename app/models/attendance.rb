class Attendance < ApplicationRecord
    belongs_to :user
    validate :started_at_none
    validates :worked_on, presence: true
    validate :finished_at_fast
    def started_at_none
        if started_at.nil? && finished_at.present?
            errors.add(:finished_at, "は出勤時間が無いため登録できません。")
        end
    end
    
    def finished_at_fast
        if started_at.present? && finished_at.present? && finished_at < started_at
            errors.add(:finished_at, "は出勤時間より早いため登録できません。")
        end
    end
end