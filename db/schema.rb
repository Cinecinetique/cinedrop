# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131118105101) do

  create_table "documents", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.integer  "project_id"
    t.string   "scene_number"
    t.integer  "created_by"
    t.string   "type"
    t.string   "data_ref"
    t.string   "data_host"
    t.integer  "changed_by"
    t.string   "location"
    t.string   "page"
  end

  add_index "documents", ["project_id"], name: "index_documents_on_project_id"

  create_table "payments", force: true do |t|
    t.integer  "subscription_id"
    t.integer  "worker_id"
    t.datetime "settlement_date"
    t.string   "service"
    t.float    "amount"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payments", ["subscription_id"], name: "index_payments_on_subscription_id"
  add_index "payments", ["worker_id"], name: "index_payments_on_worker_id"

  create_table "plans", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "features"
    t.float    "price"
    t.integer  "trial_period"
    t.integer  "paid_instalments"
    t.boolean  "is_available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_projects"
    t.integer  "max_users"
    t.integer  "position"
    t.string   "call_to_action"
    t.string   "paypal_dev_button"
    t.string   "paypal_test_button"
    t.string   "paypal_prod_button"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
    t.string   "slug"
    t.datetime "date"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "scenes", force: true do |t|
    t.integer  "project_id"
    t.string   "script_story"
    t.string   "script_video"
    t.string   "script_audio"
    t.string   "slugline"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scenes", ["project_id"], name: "index_scenes_on_project_id"

  create_table "sessions", force: true do |t|
    t.string   "new"
    t.string   "create"
    t.string   "destroy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "project_id"
    t.string   "method"
    t.integer  "time_capacity"
    t.integer  "people_capacity"
    t.float    "amount"
    t.string   "currency"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["project_id"], name: "index_subscriptions_on_project_id"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.boolean  "is_admin"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

  create_table "workers", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.string   "department"
    t.string   "company"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workers", ["project_id"], name: "index_workers_on_project_id"
  add_index "workers", ["user_id"], name: "index_workers_on_user_id"

end
