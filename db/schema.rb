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

ActiveRecord::Schema.define(version: 2019_09_03_035836) do

  create_table "favorite_tweets", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "twitter_id"
    t.integer "favorite_count"
    t.integer "retweet_count"
    t.datetime "favorited_at"
    t.datetime "tweeted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_favorite_tweets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "twitter_uid"
    t.string "access_token"
    t.string "access_secret"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "favorite_tweets", "users"
end
