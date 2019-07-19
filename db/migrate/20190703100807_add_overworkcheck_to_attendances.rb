class AddOverworkcheckToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overworkcheck, :string
  end
end
