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

ActiveRecord::Schema.define(version: 20180911231410) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.decimal "price"
    t.integer "status", default: 0
    t.string "image", default: "default-image.jpg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.date "date"
    t.float "max_temperature"
    t.float "mean_temperature"
    t.float "min_temperature"
    t.float "mean_humidity"
    t.float "mean_visibility"
    t.float "mean_wind_speed"
    t.float "precipitation"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "order_accessories", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "accessory_id"
    t.index ["accessory_id"], name: "index_order_accessories_on_accessory_id"
    t.index ["order_id"], name: "index_order_accessories_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.float "total"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "stations", force: :cascade do |t|
    t.string "name"
    t.integer "dock_count"
    t.string "city"
    t.date "installation_date"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.integer "duration"
    t.datetime "start_date"
    t.bigint "start_station_id"
    t.datetime "end_date"
    t.bigint "end_station_id"
    t.integer "bike_id"
    t.string "subscription_type"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["end_station_id"], name: "index_trips_on_end_station_id"
    t.index ["start_station_id"], name: "index_trips_on_start_station_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "address"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
  end

  add_foreign_key "order_accessories", "accessories"
  add_foreign_key "order_accessories", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "trips", "stations", column: "end_station_id"
  add_foreign_key "trips", "stations", column: "start_station_id"
end
