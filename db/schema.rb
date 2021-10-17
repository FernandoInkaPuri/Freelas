# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_17_195854) do

  create_table "professionals", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status_profile", default: 5
    t.index ["email"], name: "index_professionals_on_email", unique: true
    t.index ["reset_password_token"], name: "index_professionals_on_reset_password_token", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "social_name"
    t.date "birth_date"
    t.string "formation"
    t.string "description"
    t.string "experience"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "professional_id", null: false
    t.index ["professional_id"], name: "index_profiles_on_professional_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "skills"
    t.decimal "max_value"
    t.date "limit_date"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
    t.integer "modality"
    t.boolean "open", default: true
    t.boolean "open_registration", default: true
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "proposals", force: :cascade do |t|
    t.string "reason"
    t.decimal "hour_value"
    t.integer "hours_week"
    t.string "expectation"
    t.integer "project_id", null: false
    t.integer "professional_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status_proposal", default: 0
    t.string "justify"
    t.index ["professional_id"], name: "index_proposals_on_professional_id"
    t.index ["project_id"], name: "index_proposals_on_project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "profiles", "professionals"
  add_foreign_key "projects", "users"
  add_foreign_key "proposals", "professionals"
  add_foreign_key "proposals", "projects"
end
