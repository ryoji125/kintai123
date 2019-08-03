class AddMonthcheckToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :month_ok_check, :string
    add_column :attendances, :month_checker, :string
    add_column :attendances, :month_confirmation, :string
  end
end
