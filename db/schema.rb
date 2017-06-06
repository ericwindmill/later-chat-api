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

ActiveRecord::Schema.define(version: 20170606145712) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id", null: false
    t.integer  "leader_id",   null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["follower_id"], name: "index_follows_on_follower_id", using: :btree
    t.index ["leader_id"], name: "index_follows_on_leader_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.integer  "post_id",                      null: false
    t.integer  "recipient_id",                 null: false
    t.boolean  "read_status",  default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["post_id"], name: "index_notes_on_post_id", using: :btree
    t.index ["recipient_id"], name: "index_notes_on_recipient_id", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.text     "body",                       null: false
    t.string   "location",                   null: false
    t.string   "image_url"
    t.boolean  "public",     default: false
    t.integer  "author_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["location"], name: "index_posts_on_location", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token", using: :btree
    t.index ["session_token"], name: "index_users_on_session_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
