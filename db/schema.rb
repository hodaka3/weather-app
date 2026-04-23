# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_23_034942) do
  create_table "cities", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "jp_name"
    t.float "latitude"
    t.float "longitude"
    t.string "name"
    t.integer "prefecture_id", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_cities_on_prefecture_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "weather_records", force: :cascade do |t|
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "datetime"
    t.integer "humidity"
    t.string "icon"
    t.string "main"
    t.float "precipitation"
    t.float "temp"
    t.float "temperature"
    t.datetime "updated_at", null: false
    t.float "wind_speed"
    t.index ["city_id"], name: "index_weather_records_on_city_id"
  end

  add_foreign_key "cities", "prefectures"
  add_foreign_key "weather_records", "cities"
end
