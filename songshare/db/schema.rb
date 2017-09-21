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

ActiveRecord::Schema.define(version: 20170921002304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "external_id", null: false
    t.string   "name"
    t.integer  "year"
    t.string   "album_type"
    t.string   "genres",                   array: true
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["album_type"], name: "index_albums_on_album_type", using: :btree
    t.index ["external_id"], name: "index_albums_on_external_id", using: :btree
  end

  create_table "albums_artists", id: false, force: :cascade do |t|
    t.integer "album_id",  null: false
    t.integer "artist_id", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "external_id", null: false
    t.string   "name"
    t.string   "genres",                   array: true
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "artists_songs", id: false, force: :cascade do |t|
    t.integer "artist_id", null: false
    t.integer "song_id",   null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friendships_on_friend_id", using: :btree
    t.index ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_friendships_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "height"
    t.integer  "width"
    t.string   "url",            null: false
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree
  end

  create_table "recommendations", force: :cascade do |t|
    t.integer  "from",       null: false
    t.integer  "to",         null: false
    t.integer  "song_id",    null: false
    t.boolean  "liked"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "comments"
    t.index ["from", "to"], name: "index_recommendations_on_from_and_to", using: :btree
    t.index ["to", "from", "song_id"], name: "index_recommendations_on_to_and_from_and_song_id", unique: true, using: :btree
  end

  create_table "songs", force: :cascade do |t|
    t.string   "external_id",              null: false
    t.string   "title"
    t.integer  "disc_number",  default: 1
    t.integer  "track_number"
    t.boolean  "explicit"
    t.integer  "duration"
    t.integer  "album_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["album_id", "disc_number", "track_number"], name: "index_songs_on_album_id_and_disc_number_and_track_number", using: :btree
    t.index ["album_id"], name: "index_songs_on_album_id", using: :btree
    t.index ["external_id"], name: "index_songs_on_external_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "full_name"
    t.string   "display_name"
    t.string   "location"
    t.string   "email"
    t.integer  "sign_in_count",      default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", using: :btree
  end

  add_foreign_key "albums_artists", "albums"
  add_foreign_key "albums_artists", "artists"
  add_foreign_key "artists_songs", "artists"
  add_foreign_key "artists_songs", "songs"
  add_foreign_key "recommendations", "songs"
  add_foreign_key "recommendations", "users", column: "from"
  add_foreign_key "recommendations", "users", column: "to"
  add_foreign_key "songs", "albums"
end
