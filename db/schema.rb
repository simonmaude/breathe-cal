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

ActiveRecord::Schema.define(version: 20170730003252) do

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.string   "country"
    t.string   "location_key"
    t.string   "zip"
    t.text     "daily_data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "lat"
    t.string   "lng"
    t.integer  "user_id"
    t.integer  "client_id"
  end

  add_index "cities", ["client_id"], name: "index_cities_on_client_id"
  add_index "cities", ["user_id"], name: "index_cities_on_user_id"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "searches"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "location"
    t.boolean  "email_digest"
    t.boolean  "email_alert"
  end

  create_table "email_managers", force: :cascade do |t|
    t.string   "alert"
    t.string   "previous_alert"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "markers", force: :cascade do |t|
    t.string   "lng"
    t.string   "lat"
    t.string   "title"
    t.integer  "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "markers", ["client_id"], name: "index_markers_on_client_id"

  create_table "users", force: :cascade do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.text     "description"
    t.string   "title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

end
