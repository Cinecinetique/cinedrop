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

ActiveRecord::Schema.define(version: 20130829105117) do

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

  create_table "projects", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by"
  end

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
  end

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
