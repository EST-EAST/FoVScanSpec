class AddLogDetails < ActiveRecord::Migration
  def self.up
    add_column :sweep_ex_logs, :step, :integer
    add_column :sweep_ex_logs, :x, :integer
    add_column :sweep_ex_logs, :y, :integer
    add_column :sweep_ex_logs, :x_coord, :float
    add_column :sweep_ex_logs, :y_coord, :float
    add_column :sweep_ex_logs, :timestr, :string
    add_column :sweep_ex_logs, :dtinit, :datetime
    add_column :sweep_ex_logs, :dtend, :datetime

    change_column :sweep_eng_runs, :sweep_ex_logs_count, :integer, :null => false, :default => 0

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, :null => false, :default => 0

    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :sweep_ex_logs, :step
    remove_column :sweep_ex_logs, :x
    remove_column :sweep_ex_logs, :y
    remove_column :sweep_ex_logs, :x_coord
    remove_column :sweep_ex_logs, :y_coord
    remove_column :sweep_ex_logs, :timestr
    remove_column :sweep_ex_logs, :dtinit
    remove_column :sweep_ex_logs, :dtend

    change_column :sweep_eng_runs, :sweep_ex_logs_count, :integer, default: 0, null: false

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, default: 0, null: false

    change_column :sweeps, :sweep_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
