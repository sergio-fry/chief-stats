# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151201172806) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "cookie_id"
    t.integer  "sessions_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "page_views", force: :cascade do |t|
    t.text     "url"
    t.text     "referer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "session_id"
  end

  add_index "page_views", ["session_id"], name: "index_page_views_on_session_id", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id"
    t.string   "domain"
    t.integer  "page_views_count"
    t.text     "referer"
    t.cidr     "ip"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "user_agent"
    t.integer  "client_id"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree

end
