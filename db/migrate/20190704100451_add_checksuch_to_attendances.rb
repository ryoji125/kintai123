class AddChecksuchToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :overconfirmation, :string #残業申請の支持者確認で使う
  end
end
