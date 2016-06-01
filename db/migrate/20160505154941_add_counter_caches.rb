class AddCounterCaches < ActiveRecord::Migration
  def self.up
    add_column :fovs, :scans_count, :integer, :default => 0, :null => false

    add_column :windows, :scans_count, :integer, :default => 0, :null => false

    add_column :scan_types, :scans_count, :integer, :default => 0, :null => false

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :fovs, :scans_count

    remove_column :windows, :scans_count

    remove_column :scan_types, :scans_count

    change_column :users, :administrator, :boolean, default: false
  end
end
