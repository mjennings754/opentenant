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

ActiveRecord::Schema[8.1].define(version: 2026_03_01_120949) do
  create_table "invitations", force: :cascade do |t|
    t.datetime "accepted_at"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.integer "invitable_id"
    t.string "invitable_type"
    t.integer "invited_user_id", null: false
    t.integer "inviter_id"
    t.string "inviter_type"
    t.string "role"
    t.string "token", null: false
    t.datetime "updated_at", null: false
    t.index ["invitable_type", "invitable_id"], name: "index_invitations_on_invitable"
    t.index ["invited_user_id"], name: "index_invitations_on_invited_user_id"
    t.index ["inviter_type", "inviter_id"], name: "index_invitations_on_inviter"
  end

  create_table "members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "organization_id", null: false
    t.string "role"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["organization_id"], name: "index_members_on_organization_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "properties", force: :cascade do |t|
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.datetime "created_at", null: false
    t.integer "organization_id", null: false
    t.string "postcode"
    t.string "state"
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_properties_on_organization_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.string "firstname"
    t.string "lastname"
    t.string "password_digest"
    t.datetime "updated_at", null: false
    t.string "username"
  end

  add_foreign_key "invitations", "users", column: "invited_user_id"
  add_foreign_key "members", "organizations"
  add_foreign_key "members", "users"
  add_foreign_key "organizations", "users"
  add_foreign_key "properties", "organizations"
end
