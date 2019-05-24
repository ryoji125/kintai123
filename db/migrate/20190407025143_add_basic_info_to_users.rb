class AddBasicInfoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :basic_time, :datetime, default: Time.zone.parse("2019/2/20 7:30")
    add_column :users, :work_time, :datetime, default: Time.zone.parse("2019/2/20 8:00")
    add_column :users, :designated_work_start_time, :datetime, default: Time.zone.parse( "2019/2/20 9:00")
    add_column :users, :designated_work_end_time, :datetime, default: Time.zone.parse("2019/2/20 18:00")
  end
end
