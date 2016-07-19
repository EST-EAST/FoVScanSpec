class EngrunAttributesUpdated < ActiveRecord::Migration
  def self.up
    drop_table :sweep_ex_logs

    add_column :scan_eng_runs, :use_cam, :boolean
    add_column :scan_eng_runs, :stab_time, :float
    add_column :scan_eng_runs, :use_sim, :boolean
    add_column :scan_eng_runs, :proto_rev, :integer
    add_column :scan_eng_runs, :ls1_va, :float
    add_column :scan_eng_runs, :ls2_va, :float
    add_column :scan_eng_runs, :ls3_va, :float
    add_column :scan_eng_runs, :ls1_vh, :float
    add_column :scan_eng_runs, :ls2_vh, :float
    add_column :scan_eng_runs, :ls3_vh, :float
    add_column :scan_eng_runs, :ls1_vi, :float
    add_column :scan_eng_runs, :ls2_vi, :float
    add_column :scan_eng_runs, :ls3_vi, :float
    add_column :scan_eng_runs, :ls1_scale, :float
    add_column :scan_eng_runs, :ls2_scale, :float
    add_column :scan_eng_runs, :ls3_scale, :float
    add_column :scan_eng_runs, :ls1_min, :integer
    add_column :scan_eng_runs, :ls2_min, :integer
    add_column :scan_eng_runs, :ls3_min, :integer
    add_column :scan_eng_runs, :ls1_max, :integer
    add_column :scan_eng_runs, :ls2_max, :integer
    add_column :scan_eng_runs, :ls3_max, :integer
    add_column :scan_eng_runs, :ls1_zero, :integer
    add_column :scan_eng_runs, :ls2_zero, :integer
    add_column :scan_eng_runs, :ls3_zero, :integer
    remove_column :scan_eng_runs, :max_l1_speed
    remove_column :scan_eng_runs, :max_l2_speed
    remove_column :scan_eng_runs, :max_l3_speed
  end

  def self.down
    remove_column :scan_eng_runs, :use_cam
    remove_column :scan_eng_runs, :stab_time
    remove_column :scan_eng_runs, :use_sim
    remove_column :scan_eng_runs, :proto_rev
    remove_column :scan_eng_runs, :ls1_va
    remove_column :scan_eng_runs, :ls2_va
    remove_column :scan_eng_runs, :ls3_va
    remove_column :scan_eng_runs, :ls1_vh
    remove_column :scan_eng_runs, :ls2_vh
    remove_column :scan_eng_runs, :ls3_vh
    remove_column :scan_eng_runs, :ls1_vi
    remove_column :scan_eng_runs, :ls2_vi
    remove_column :scan_eng_runs, :ls3_vi
    remove_column :scan_eng_runs, :ls1_scale
    remove_column :scan_eng_runs, :ls2_scale
    remove_column :scan_eng_runs, :ls3_scale
    remove_column :scan_eng_runs, :ls1_min
    remove_column :scan_eng_runs, :ls2_min
    remove_column :scan_eng_runs, :ls3_min
    remove_column :scan_eng_runs, :ls1_max
    remove_column :scan_eng_runs, :ls2_max
    remove_column :scan_eng_runs, :ls3_max
    remove_column :scan_eng_runs, :ls1_zero
    remove_column :scan_eng_runs, :ls2_zero
    remove_column :scan_eng_runs, :ls3_zero
    add_column :scan_eng_runs, :max_l1_speed, :float
    add_column :scan_eng_runs, :max_l2_speed, :float
    add_column :scan_eng_runs, :max_l3_speed, :float

    create_table "sweep_ex_logs", force: :cascade do |t|
      t.float    "mx"
      t.float    "my"
      t.float    "mcomp"
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "sweep_eng_run_id"
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
    end
  end
end
