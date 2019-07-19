class AddOverworkToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overwork_note, :string
    add_column :attendances, :overworkfinished_at, :datetime 
    add_column :attendances, :overcheck, :string
    add_column :attendances, :superior_id, :boolean
  end
end
