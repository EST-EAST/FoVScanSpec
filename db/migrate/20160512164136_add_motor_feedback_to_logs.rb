class AddMotorFeedbackToLogs < ActiveRecord::Migration
  def self.up
    rename_column :scan_ex_logs, :a, :m1
    rename_column :scan_ex_logs, :b, :m2
    rename_column :scan_ex_logs, :c, :m3
    add_column :scan_ex_logs, :m1_fdback, :float
    add_column :scan_ex_logs, :m2_fdback, :float
    add_column :scan_ex_logs, :m3_fdback, :float

    change_column :scan_eng_runs, :scan_ex_logs_count, :integer, :null => false, :default => 0

    change_column :scan_exes, :scan_eng_runs_count, :integer, :null => false, :default => 0

    change_column :scans, :scan_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    rename_column :scan_ex_logs, :m1, :a
    rename_column :scan_ex_logs, :m2, :b
    rename_column :scan_ex_logs, :m3, :c
    remove_column :scan_ex_logs, :m1_fdback
    remove_column :scan_ex_logs, :m2_fdback
    remove_column :scan_ex_logs, :m3_fdback

    change_column :scan_eng_runs, :scan_ex_logs_count, :integer, default: 0, null: false

    change_column :scan_exes, :scan_eng_runs_count, :integer, default: 0, null: false

    change_column :scans, :scan_exes_count, :integer, default: 0, null: false

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
