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

ActiveRecord::Schema.define(version: 20160728200727) do

  create_table "fovs", force: :cascade do |t|
    t.string   "name"
    t.float    "size_x"
    t.float    "size_y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scans_count", default: 0,     null: false
    t.float    "zero_x"
    t.float    "zero_y"
    t.boolean  "inverse_x",   default: false
    t.boolean  "inverse_y",   default: false
    t.float    "size_z"
    t.float    "zero_z"
    t.boolean  "inverse_z",   default: false
    t.boolean  "raw_units",   default: false
  end

  create_table "scan_eng_runs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scan_ex_id"
    t.boolean  "use_cam"
    t.float    "stab_time"
    t.boolean  "use_sim"
    t.integer  "proto_rev"
    t.float    "ls1_va"
    t.float    "ls2_va"
    t.float    "ls3_va"
    t.float    "ls1_vh"
    t.float    "ls2_vh"
    t.float    "ls3_vh"
    t.float    "ls1_vi"
    t.float    "ls2_vi"
    t.float    "ls3_vi"
    t.float    "ls1_scale"
    t.float    "ls2_scale"
    t.float    "ls3_scale"
    t.integer  "ls1_min"
    t.integer  "ls2_min"
    t.integer  "ls3_min"
    t.integer  "ls1_max"
    t.integer  "ls2_max"
    t.integer  "ls3_max"
    t.integer  "ls1_zero"
    t.integer  "ls2_zero"
    t.integer  "ls3_zero"
    t.float    "comp_factor_x", default: 1.0
    t.float    "comp_factor_y", default: 1.0
    t.float    "comp_divisor",  default: 2.0
  end

  add_index "scan_eng_runs", ["scan_ex_id"], name: "index_scan_eng_runs_on_scan_ex_id"

  create_table "scan_ex_logs", force: :cascade do |t|
    t.float    "mx"
    t.float    "my"
    t.float    "mcomp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scan_eng_run_id"
    t.integer  "step"
    t.integer  "x"
    t.integer  "y"
    t.float    "x_coord"
    t.float    "y_coord"
    t.string   "timestr"
    t.datetime "dtinit"
    t.datetime "dtend"
    t.float    "mx_fdback"
    t.float    "my_fdback"
    t.float    "mcomp_fdback"
    t.integer  "iteration",       default: 0
    t.integer  "step_order"
  end

  add_index "scan_ex_logs", ["scan_eng_run_id"], name: "index_scan_ex_logs_on_scan_eng_run_id"

  create_table "scan_exes", force: :cascade do |t|
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
    t.integer  "scan_id"
    t.integer  "scan_eng_runs_count", default: 0,     null: false
    t.integer  "step_min_x"
    t.integer  "step_min_y"
    t.boolean  "z_y_exchange",        default: false
  end

  add_index "scan_exes", ["scan_id"], name: "index_scan_exes_on_scan_id"

  create_table "scan_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "scans_count", default: 0, null: false
    t.string   "type"
  end

  add_index "scan_types", ["type"], name: "index_scan_types_on_type"

  create_table "scans", force: :cascade do |t|
    t.boolean  "double_sampling"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fov_id"
    t.integer  "window_id"
    t.integer  "scan_type_id"
    t.integer  "scan_exes_count", default: 0, null: false
  end

  add_index "scans", ["fov_id"], name: "index_scans_on_fov_id"
  add_index "scans", ["scan_type_id"], name: "index_scans_on_scan_type_id"
  add_index "scans", ["window_id"], name: "index_scans_on_window_id"

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
    t.integer  "scans_count", default: 0, null: false
  end

end
