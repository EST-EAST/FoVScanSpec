class AddSweepexCount < ActiveRecord::Migration
  def self.up
    add_column :sweeps, :sweeps_exes_count, :integer, :default => 0, :null => false

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :sweeps, :sweeps_exes_count

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
