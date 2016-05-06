class AddSweepexRelationships < ActiveRecord::Migration
  def self.up
    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false

    add_column :sweep_exes, :step_init_coord, :string
    add_column :sweep_exes, :step_init_x, :float
    add_column :sweep_exes, :step_init_y, :float
    add_column :sweep_exes, :repetitions, :integer
    add_column :sweep_exes, :created_at, :datetime
    add_column :sweep_exes, :updated_at, :datetime
    add_column :sweep_exes, :sweep_id, :integer

    add_index :sweep_exes, [:sweep_id]
  end

  def self.down
    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    remove_column :sweep_exes, :step_init_coord
    remove_column :sweep_exes, :step_init_x
    remove_column :sweep_exes, :step_init_y
    remove_column :sweep_exes, :repetitions
    remove_column :sweep_exes, :created_at
    remove_column :sweep_exes, :updated_at
    remove_column :sweep_exes, :sweep_id

    remove_index :sweep_exes, :name => :index_sweep_exes_on_sweep_id rescue ActiveRecord::StatementInvalid
  end
end
