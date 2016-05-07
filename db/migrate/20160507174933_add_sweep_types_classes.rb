class AddSweepTypesClasses < ActiveRecord::Migration
  def self.up
    create_table :raster_sweep_types do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, :null => false, :default => 0

    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    add_column :sweep_types, :type, :string
    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false

    add_index :sweep_types, [:type]
  end

  def self.down
    change_column :sweep_exes, :sweep_eng_runs_count, :integer, default: 0, null: false

    change_column :sweeps, :sweep_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    remove_column :sweep_types, :type
    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    drop_table :raster_sweep_types

    remove_index :sweep_types, :name => :index_sweep_types_on_type rescue ActiveRecord::StatementInvalid
  end
end
