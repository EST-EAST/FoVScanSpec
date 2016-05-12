class AddMotorFeedbackToLogs < ActiveRecord::Migration
  def self.up
    rename_column :sweep_ex_logs, :a, :m1
    rename_column :sweep_ex_logs, :b, :m2
    rename_column :sweep_ex_logs, :c, :m3
    add_column :sweep_ex_logs, :m1_fdback, :float
    add_column :sweep_ex_logs, :m2_fdback, :float
    add_column :sweep_ex_logs, :m3_fdback, :float

    change_column :sweep_eng_runs, :sweep_ex_logs_count, :integer, :null => false, :default => 0

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, :null => false, :default => 0

    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    rename_column :sweep_ex_logs, :m1, :a
    rename_column :sweep_ex_logs, :m2, :b
    rename_column :sweep_ex_logs, :m3, :c
    remove_column :sweep_ex_logs, :m1_fdback
    remove_column :sweep_ex_logs, :m2_fdback
    remove_column :sweep_ex_logs, :m3_fdback

    change_column :sweep_eng_runs, :sweep_ex_logs_count, :integer, default: 0, null: false

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, default: 0, null: false

    change_column :sweeps, :sweep_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
