class AddCounterCaches < ActiveRecord::Migration
  def self.up
    add_column :fovs, :sweeps_count, :integer, :default => 0, :null => false

    add_column :windows, :sweeps_count, :integer, :default => 0, :null => false

    add_column :sweep_types, :sweeps_count, :integer, :default => 0, :null => false

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :fovs, :sweeps_count

    remove_column :windows, :sweeps_count

    remove_column :sweep_types, :sweeps_count

    change_column :users, :administrator, :boolean, default: false
  end
end
