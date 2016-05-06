class AddSweepRelationships < ActiveRecord::Migration
  def self.up
    add_column :sweeps, :fov_id, :integer
    add_column :sweeps, :window_id, :integer
    add_column :sweeps, :sweep_type_id, :integer

    change_column :users, :administrator, :boolean, :default => false

    add_index :sweeps, [:fov_id]
    add_index :sweeps, [:window_id]
    add_index :sweeps, [:sweep_type_id]
  end

  def self.down
    remove_column :sweeps, :fov_id
    remove_column :sweeps, :window_id
    remove_column :sweeps, :sweep_type_id

    change_column :users, :administrator, :boolean, default: false

    remove_index :sweeps, :name => :index_sweeps_on_fov_id rescue ActiveRecord::StatementInvalid
    remove_index :sweeps, :name => :index_sweeps_on_window_id rescue ActiveRecord::StatementInvalid
    remove_index :sweeps, :name => :index_sweeps_on_sweep_type_id rescue ActiveRecord::StatementInvalid
  end
end
