class AddMotorFeedbackToLogs < ActiveRecord::Migration
  def self.up
    rename_column :scan_ex_logs, :a, :m1
    rename_column :scan_ex_logs, :b, :m2
    rename_column :scan_ex_logs, :c, :m3
    add_column :scan_ex_logs, :m1_fdback, :float
    add_column :scan_ex_logs, :m2_fdback, :float
    add_column :scan_ex_logs, :m3_fdback, :float
  end

  def self.down
    rename_column :scan_ex_logs, :m1, :a
    rename_column :scan_ex_logs, :m2, :b
    rename_column :scan_ex_logs, :m3, :c
    remove_column :scan_ex_logs, :m1_fdback
    remove_column :scan_ex_logs, :m2_fdback
    remove_column :scan_ex_logs, :m3_fdback
  end
end
