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

ActiveRecord::Schema.define(version: 20160507185217) do

  create_table "fovs", force: :cascade do |t|
    t.string   "name"
    t.float    "size_x"
    t.float    "size_y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sweeps_count", default: 0, null: false
  end

  create_table "sweep_eng_runs", force: :cascade do |t|
    t.string   "name"
    t.float    "max_l1_speed"
    t.float    "max_l2_speed"
    t.float    "max_l3_speed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sweep_ex_id"
  end

  add_index "sweep_eng_runs", ["sweep_ex_id"], name: "index_sweep_eng_runs_on_sweep_ex_id"

  create_table "sweep_exes", force: :cascade do |t|
    t.string   "name"
    t.float    "step_size_x"
    t.integer  "step_number_x"
    t.string   "step_dir_x"
    t.float    "step_size_y"
    t.integer  "step_number_y"
    t.string   "step_dir_y"
    t.string   "step_init_coord"
    t.float    "step_init_x"
    t.float    "step_init_y"
    t.integer  "repetitions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sweep_id"
    t.integer  "sweep_eng_runs_count", default: 0, null: false
    t.integer  "step_min_x"
    t.integer  "step_min_y"
  end

  add_index "sweep_exes", ["sweep_id"], name: "index_sweep_exes_on_sweep_id"

  create_table "sweep_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sweeps_count", default: 0, null: false
    t.string   "type"
  end

  add_index "sweep_types", ["type"], name: "index_sweep_types_on_type"

  create_table "sweeps", force: :cascade do |t|
    t.boolean  "double_sampling"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fov_id"
    t.integer  "window_id"
    t.integer  "sweep_type_id"
    t.integer  "sweep_exes_count", default: 0, null: false
  end

  add_index "sweeps", ["fov_id"], name: "index_sweeps_on_fov_id"
  add_index "sweeps", ["sweep_type_id"], name: "index_sweeps_on_sweep_type_id"
  add_index "sweeps", ["window_id"], name: "index_sweeps_on_window_id"

  create_table "users", force: :cascade do |t|
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                default: "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], name: "index_users_on_state"

  create_table "windows", force: :cascade do |t|
    t.string   "name"
    t.float    "size_x"
    t.float    "size_y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sweeps_count", default: 0, null: false
  end

end
