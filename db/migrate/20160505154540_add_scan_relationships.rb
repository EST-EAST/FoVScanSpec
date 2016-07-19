class AddScanRelationships < ActiveRecord::Migration
  def self.up
    add_column :scans, :fov_id, :integer
    add_column :scans, :window_id, :integer
    add_column :scans, :scan_type_id, :integer

    add_index :scans, [:fov_id]
    add_index :scans, [:window_id]
    add_index :scans, [:scan_type_id]
  end

  def self.down
    remove_column :scans, :fov_id
    remove_column :scans, :window_id
    remove_column :scans, :scan_type_id

    remove_index :scans, :name => :index_scans_on_fov_id rescue ActiveRecord::StatementInvalid
    remove_index :scans, :name => :index_scans_on_window_id rescue ActiveRecord::StatementInvalid
    remove_index :scans, :name => :index_scans_on_scan_type_id rescue ActiveRecord::StatementInvalid
  end
end
