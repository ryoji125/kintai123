ActiveRecord::Schema.define(version: 20190703100807) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"   　　　　　　　　　　　勤怠の日ずけが入っている
    t.datetime "started_at" 　　               出社時間    
    t.datetime "finished_at"　　　　　　　　　　退社時間
    t.string "note"                             特筆事項を入れる際に
    t.integer "user_id"                         勤怠の中にありユーザーのidと同じようなもの勤怠の中にあるので色々な勤怠にいる
    t.datetime "created_at", null: false        その勤怠がみられた時に自動的に生成されている
    t.datetime "updated_at", null: false        その勤怠が更新時に自動的に生成されている
    残業申請
    t.string "overwork_note"                    残業の業務内容処理に使用
    t.datetime "overworkfinished_at"            残業の終わる時間が入っている
    t.string "overcheck"                        1であれば仕事終わりは翌日それ以外は当日
    t.boolean "superior_id"                     今は使っていない
    t.string "overcheker"                       残業を誰に申請したかを入れている
    t.string "overworkcheck"                    残業の申請を変更するかどうかを入れる　　                        
    t.string "overconfirmation"                 残業の確認状態を入れる(指示者確認)　申請中等
    
    勤怠変更
    t.datetime "attendances_finished_at"   勤怠変更の時間を入れる (仕事を終わる時間)
    t.datetime "attendances_started_at"    勤怠変更の時間を入れる (仕事を始める時間)
    t.string "attendancecheck"             勤怠情報の変更を申請するときに使う
    t.string "attendances_note"　　　　　　勤怠変更のの備考を入れる。
    t.string "attendances_confirmation"    勤怠変更の申請等を入れる
    t.string "attendances_cheker"          確認者を入れる。　上長
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.string "atype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_work_time", default: "2019-02-19 22:30:00"
    t.datetime "work_time", default: "2019-02-19 23:00:00"
    t.datetime "designated_work_start_time", default: "2019-02-20 00:00:00"
    t.datetime "designated_work_end_time", default: "2019-02-20 10:00:00"
    t.string "remember_digest"
    t.boolean "superior", default: false
    t.string "uid"
    t.string "employee_number", default: "1"
    t.string "affiliation"
    t.index ["email"], name: "index_users_on_email", unique: true
  end
end
