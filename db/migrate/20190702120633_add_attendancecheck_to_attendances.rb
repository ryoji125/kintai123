class AddAttendancecheckToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :attendancecheck, :string
    add_column :attendances, :attendances_finished_at, :datetime
    add_column :attendances, :attendances_started_at, :datetime
    add_column :attendances, :attendances_note, :string
    add_column :attendances, :attendances_confirmation, :string
    add_column :attendances, :attendances_cheker, :string
    add_column :attendances, :attendances_check, :string
  end
end
