class AdaptScanAlg < ActiveRecord::Migration
  def self.up
    drop_table :raster_scan_types

    add_column :scan_exes, :step_min_x, :integer
    add_column :scan_exes, :step_min_y, :integer
    change_column :scan_exes, :step_number_x, :integer
    change_column :scan_exes, :step_number_y, :integer
  end

  def self.down
    remove_column :scan_exes, :step_min_x
    remove_column :scan_exes, :step_min_y
    change_column :scan_exes, :step_number_x, :float
    change_column :scan_exes, :step_number_y, :float

    create_table "raster_scan_types", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
