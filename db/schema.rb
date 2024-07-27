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

ActiveRecord::Schema[7.0].define(version: 2024_07_21_083648) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "geolocations", force: :cascade do |t|
    t.string "ip_address", default: "", null: false
    t.string "ip_address_type"
    t.string "continent_name", default: ""
    t.string "continent_code", default: ""
    t.string "country", default: "", null: false
    t.string "country_code", default: ""
    t.string "region", default: "", null: false
    t.string "region_code", default: ""
    t.string "city", default: "", null: false
    t.string "zip", default: "", null: false
    t.float "latitude", null: false
    t.float "longitude", null: false
    t.string "timezone"
    t.string "isp"
    t.string "org"
    t.string "offset"
    t.string "host_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_address"], name: "index_geolocations_on_ip_address", unique: true
    t.index ["latitude", "longitude"], name: "index_geolocations_on_latitude_and_longitude"
  end

end
