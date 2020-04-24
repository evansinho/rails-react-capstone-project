# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_23_203320) do

  create_table "meetings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "date"
    t.text "confirmed_members"
    t.integer "meet_id", null: false
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meet_id"], name: "index_meetings_on_meet_id"
  end

  create_table "meets", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "frequency"
    t.float "duration"
    t.string "day"
    t.integer "members"
    t.integer "max_members"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "created_by"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.integer "meeting_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "picture"
    t.index ["meeting_id"], name: "index_users_on_meeting_id"
  end

  add_foreign_key "meetings", "meets"
  add_foreign_key "users", "meetings"
end
