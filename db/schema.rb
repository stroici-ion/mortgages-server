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

ActiveRecord::Schema[8.0].define(version: 2024_12_16_170506) do
  create_table "form_progresses", force: :cascade do |t|
    t.boolean "action_type_completed"
    t.boolean "location_completed"
    t.boolean "property_type_completed"
    t.boolean "price_completed"
    t.boolean "about_user_completed"
    t.boolean "date_completed"
    t.boolean "targets_completed"
    t.boolean "gift_funds_completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "active_step", null: false
    t.boolean "form_completed", default: false, null: false
  end

  create_table "loans", force: :cascade do |t|
    t.integer "action_type"
    t.string "country"
    t.string "address"
    t.string "zip_code"
    t.float "latitude"
    t.float "longitude"
    t.integer "property_type"
    t.decimal "price"
    t.decimal "down_payment_rate"
    t.decimal "down_payment"
    t.integer "user_situation"
    t.date "date"
    t.integer "duration"
    t.decimal "monthly_payment"
    t.decimal "rate"
    t.decimal "reverse_amount"
    t.decimal "gift_funds"
    t.string "is_document_reviewed"
    t.string "is_pending_final_approval"
    t.string "is_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "form_progress_id", null: false
    t.index ["form_progress_id"], name: "index_loans_on_form_progress_id"
  end

  add_foreign_key "loans", "form_progresses"
end
