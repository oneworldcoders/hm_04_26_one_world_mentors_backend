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

ActiveRecord::Schema.define(version: 2020_07_24_144039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "courseCode", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mentees", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "mentor_id"
    t.index ["course_id"], name: "index_mentees_on_course_id"
    t.index ["mentor_id"], name: "index_mentees_on_mentor_id"
    t.index ["user_id"], name: "index_mentees_on_user_id"
  end

  create_table "mentor_courses", force: :cascade do |t|
    t.bigint "mentor_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_mentor_courses_on_course_id"
    t.index ["mentor_id"], name: "index_mentor_courses_on_mentor_id"
  end

  create_table "mentors", force: :cascade do |t|
    t.boolean "available", default: true
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_mentors_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password", null: false
    t.string "user_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_url"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "mentees", "courses"
  add_foreign_key "mentees", "mentors"
  add_foreign_key "mentees", "users"
  add_foreign_key "mentor_courses", "courses"
  add_foreign_key "mentor_courses", "mentors"
  add_foreign_key "mentors", "users"
end
