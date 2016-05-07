class AdaptSweepAlg < ActiveRecord::Migration
  def self.up
    drop_table :raster_sweep_types

    add_column :sweep_exes, :step_min_x, :integer
    add_column :sweep_exes, :step_min_y, :integer
    change_column :sweep_exes, :step_number_x, :integer
    change_column :sweep_exes, :step_number_y, :integer
    change_column :sweep_exes, :sweep_eng_runs_count, :integer, :null => false, :default => 0

    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :sweep_exes, :step_min_x
    remove_column :sweep_exes, :step_min_y
    change_column :sweep_exes, :step_number_x, :float
    change_column :sweep_exes, :step_number_y, :float
    change_column :sweep_exes, :sweep_eng_runs_count, :integer, default: 0, null: false

    change_column :sweeps, :sweep_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    create_table "raster_sweep_types", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
