class AddLogDetails < ActiveRecord::Migration
  def self.up
    add_column :scan_ex_logs, :step, :integer
    add_column :scan_ex_logs, :x, :integer
    add_column :scan_ex_logs, :y, :integer
    add_column :scan_ex_logs, :x_coord, :float
    add_column :scan_ex_logs, :y_coord, :float
    add_column :scan_ex_logs, :timestr, :string
    add_column :scan_ex_logs, :dtinit, :datetime
    add_column :scan_ex_logs, :dtend, :datetime

    change_column :scan_eng_runs, :scan_ex_logs_count, :integer, :null => false, :default => 0

    change_column :scan_exes, :scan_eng_runs_count, :integer, :null => false, :default => 0

    change_column :scans, :scan_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :scan_ex_logs, :step
    remove_column :scan_ex_logs, :x
    remove_column :scan_ex_logs, :y
    remove_column :scan_ex_logs, :x_coord
    remove_column :scan_ex_logs, :y_coord
    remove_column :scan_ex_logs, :timestr
    remove_column :scan_ex_logs, :dtinit
    remove_column :scan_ex_logs, :dtend

    change_column :scan_eng_runs, :scan_ex_logs_count, :integer, default: 0, null: false

    change_column :scan_exes, :scan_eng_runs_count, :integer, default: 0, null: false

    change_column :scans, :scan_exes_count, :integer, default: 0, null: false

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
