class AddScanexCount < ActiveRecord::Migration
  def self.up
    add_column :scans, :scans_exes_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :scans, :scans_exes_count
  end
end
