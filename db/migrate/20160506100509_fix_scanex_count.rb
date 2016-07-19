class FixScanexCount < ActiveRecord::Migration
  def self.up
    rename_column :scans, :scans_exes_count, :scan_exes_count
  end

  def self.down
    rename_column :scans, :scan_exes_count, :scans_exes_count
  end
end
