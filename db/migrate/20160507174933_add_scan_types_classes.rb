class AddScanTypesClasses < ActiveRecord::Migration
  def self.up
    create_table :raster_scan_types do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :scan_exes, :scan_eng_runs_count, :integer, :null => false, :default => 0

    change_column :scans, :scan_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    add_column :scan_types, :type, :string
    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false

    add_index :scan_types, [:type]
  end

  def self.down
    change_column :scan_exes, :scan_eng_runs_count, :integer, default: 0, null: false

    change_column :scans, :scan_exes_count, :integer, default: 0, null: false

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    remove_column :scan_types, :type
    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    drop_table :raster_scan_types

    remove_index :scan_types, :name => :index_scan_types_on_type rescue ActiveRecord::StatementInvalid
  end
end
