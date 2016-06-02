class RefactorSweepScan < ActiveRecord::Migration
  def self.up
    change_column :scan_eng_runs, :scan_ex_logs_count, :integer, :null => false, :default => 0

    change_column :scan_exes, :scan_eng_runs_count, :integer, :null => false, :default => 0

    change_column :scans, :scan_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false

    rename_column :scan_ex_logs, :m1, :mx
    rename_column :scan_ex_logs, :m2, :my
    rename_column :scan_ex_logs, :m3, :mcomp
    rename_column :scan_ex_logs, :m1_fdback, :mx_fdback
    rename_column :scan_ex_logs, :m2_fdback, :my_fdback
    rename_column :scan_ex_logs, :m3_fdback, :mcomp_fdback
  end

  def self.down
    change_column :scan_eng_runs, :scan_ex_logs_count, :integer, default: 0, null: false

    change_column :scan_exes, :scan_eng_runs_count, :integer, default: 0, null: false

    change_column :scans, :scan_exes_count, :integer, default: 0, null: false

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    rename_column :scan_ex_logs, :mx, :m1
    rename_column :scan_ex_logs, :my, :m2
    rename_column :scan_ex_logs, :mcomp, :m3
    rename_column :scan_ex_logs, :mx_fdback, :m1_fdback
    rename_column :scan_ex_logs, :my_fdback, :m2_fdback
    rename_column :scan_ex_logs, :mcomp_fdback, :m3_fdback
  end
end
