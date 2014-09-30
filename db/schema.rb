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

ActiveRecord::Schema.define(version: 20140930034859) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.string   "content"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "comments", ["post_id", "created_at"], name: "index_comments_on_post_id_and_created_at", using: :btree

  create_table "galleries", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "start_date"
    t.date     "end_date"
  end

  add_index "galleries", ["end_date"], name: "index_galleries_on_end_date", using: :btree
  add_index "galleries", ["start_date"], name: "index_galleries_on_start_date", using: :btree

  create_table "posts", force: true do |t|
    t.string   "text"
    t.integer  "user_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.string   "access_token"
    t.boolean  "family",               default: false
    t.boolean  "friends",              default: false
    t.boolean  "others",               default: true
    t.integer  "gallery_id"
    t.integer  "sort_index",           default: 0
  end

  add_index "posts", ["gallery_id"], name: "index_posts_on_gallery_id", using: :btree
  add_index "posts", ["sort_index"], name: "index_posts_on_sort_index", using: :btree
  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "access_token"
    t.boolean  "family",          default: false
    t.boolean  "friends",         default: false
    t.boolean  "others",          default: true
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
