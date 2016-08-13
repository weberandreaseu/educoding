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

ActiveRecord::Schema.define(version: 20160730141256) do

  create_table "class_files", force: :cascade do |t|
    t.text     "code"
    t.string   "filename"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "codeable_id"
    t.string   "codeable_type"
    t.boolean  "visible",       default: true
  end

  create_table "solutions", force: :cascade do |t|
    t.integer  "score"
    t.integer  "task_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "score"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "basic_test"
    t.text     "advanced_test"
    t.text     "stdin"
    t.string   "package"
    t.string   "main"
  end

  create_table "users", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
