class RefactorSweepScan < ActiveRecord::Migration
  def self.up
    rename_column :scan_ex_logs, :m1, :mx
    rename_column :scan_ex_logs, :m2, :my
    rename_column :scan_ex_logs, :m3, :mcomp
    rename_column :scan_ex_logs, :m1_fdback, :mx_fdback
    rename_column :scan_ex_logs, :m2_fdback, :my_fdback
    rename_column :scan_ex_logs, :m3_fdback, :mcomp_fdback
  end

  def self.down
    rename_column :scan_ex_logs, :mx, :m1
    rename_column :scan_ex_logs, :my, :m2
    rename_column :scan_ex_logs, :mcomp, :m3
    rename_column :scan_ex_logs, :mx_fdback, :m1_fdback
    rename_column :scan_ex_logs, :my_fdback, :m2_fdback
    rename_column :scan_ex_logs, :mcomp_fdback, :m3_fdback
  end
end
