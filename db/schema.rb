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

ActiveRecord::Schema.define(version: 2019_10_05_204804) do

  create_table "listings", force: :cascade do |t|
    t.string "title"
    t.string "make"
    t.string "model"
    t.string "url"
    t.float "price"
    t.text "description"
    t.string "province"
    t.string "image_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "make_id"
    t.integer "model_id"
    t.integer "province_id"
    t.index ["make_id"], name: "index_listings_on_make_id"
    t.index ["model_id"], name: "index_listings_on_model_id"
    t.index ["province_id"], name: "index_listings_on_province_id"
  end

  create_table "makes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "models", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "make_id"
    t.index ["make_id"], name: "index_models_on_make_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "listings", "makes"
  add_foreign_key "listings", "models"
  add_foreign_key "listings", "provinces"
  add_foreign_key "models", "makes"
end
