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

ActiveRecord::Schema.define(version: 20180305133154) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "offers", force: :cascade do |t|
    t.bigint "ride_id"
    t.boolean "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "request_id"
    t.integer "duration_to_car"
    t.integer "distance_to_car"
    t.integer "duration_to_dest"
    t.integer "distance_to_dest"
    t.index ["request_id"], name: "index_offers_on_request_id"
    t.index ["ride_id"], name: "index_offers_on_ride_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "start_time"
    t.datetime "stop_time"
    t.float "from_lng"
    t.float "from_lat"
    t.float "to_lng"
    t.float "to_lat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from_address"
    t.string "to_address"
    t.string "direction"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "rides", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "seats"
    t.datetime "departure_time"
    t.float "from_lng"
    t.float "from_lat"
    t.float "to_lng"
    t.float "to_lat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from_address"
    t.string "to_address"
    t.integer "duration"
    t.integer "distance"
    t.string "car_brand"
    t.string "car_color"
    t.string "direction"
    t.index ["user_id"], name: "index_rides_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "photo"
    t.string "last_name"
    t.string "first_name"
    t.boolean "admin"
    t.text "description"
    t.string "hobby"
    t.integer "semester"
    t.string "course"
    t.string "music"
    t.string "quote"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "offers", "requests"
  add_foreign_key "offers", "rides"
  add_foreign_key "requests", "users"
  add_foreign_key "rides", "users"
end
