class AddAttendancecheckToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :attendancecheck, :string
  end
end
