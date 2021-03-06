# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20190726220111) do

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "overwork_note"
    t.datetime "overworkfinished_at"
    t.string "overcheck"
    t.boolean "superior_id"
    t.string "overcheker"
    t.string "attendancecheck"
    t.datetime "attendances_finished_at"
    t.datetime "attendances_started_at"
    t.string "attendances_note"
    t.string "attendances_confirmation"
    t.string "attendances_cheker"
    t.string "attendances_check"
    t.string "overworkcheck"
    t.string "overconfirmation"
    t.string "month_ok_check"
    t.string "month_checker"
    t.string "month_confirmation"
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
