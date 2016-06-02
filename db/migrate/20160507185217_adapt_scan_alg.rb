class AdaptScanAlg < ActiveRecord::Migration
  def self.up
    drop_table :raster_scan_types

    add_column :scan_exes, :step_min_x, :integer
    add_column :scan_exes, :step_min_y, :integer
    change_column :scan_exes, :step_number_x, :integer
    change_column :scan_exes, :step_number_y, :integer
    change_column :scan_exes, :scan_eng_runs_count, :integer, :null => false, :default => 0

    change_column :scans, :scan_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :scan_exes, :step_min_x
    remove_column :scan_exes, :step_min_y
    change_column :scan_exes, :step_number_x, :float
    change_column :scan_exes, :step_number_y, :float
    change_column :scan_exes, :scan_eng_runs_count, :integer, default: 0, null: false

    change_column :scans, :scan_exes_count, :integer, default: 0, null: false

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    create_table "raster_scan_types", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
