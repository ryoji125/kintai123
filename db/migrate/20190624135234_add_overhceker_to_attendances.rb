class AddOverhcekerToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overcheker, :string
  end
end
