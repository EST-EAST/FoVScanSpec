class FixSweepexCount < ActiveRecord::Migration
  def self.up
    rename_column :sweeps, :sweeps_exes_count, :sweep_exes_count
    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    rename_column :sweeps, :sweep_exes_count, :sweeps_exes_count
    change_column :sweeps, :sweeps_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
