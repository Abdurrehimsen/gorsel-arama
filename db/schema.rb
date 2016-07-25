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

ActiveRecord::Schema.define(version: 20160725200426) do

  create_table "photos", force: true do |t|
    t.integer  "docid"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "possibilities", force: true do |t|
    t.float    "poss"
    t.integer  "tag_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "possibilities", ["photo_id"], name: "index_possibilities_on_photo_id"
  add_index "possibilities", ["tag_id"], name: "index_possibilities_on_tag_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
