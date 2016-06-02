class AddScanexCount < ActiveRecord::Migration
  def self.up
    add_column :scans, :scans_exes_count, :integer, :default => 0, :null => false

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :scans, :scans_exes_count

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false
  end
end
