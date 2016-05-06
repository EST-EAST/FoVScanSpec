class AddSweepengrun < ActiveRecord::Migration
  def self.up
    create_table :sweep_eng_runs do |t|
      t.string   :name
      t.float    :max_l1_speed
      t.float    :max_l2_speed
      t.float    :max_l3_speed
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :sweep_ex_id
    end
    add_index :sweep_eng_runs, [:sweep_ex_id]

    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    add_column :sweep_exes, :sweep_eng_runs_count, :integer, :default => 0, :null => false

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :sweeps, :sweep_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    remove_column :sweep_exes, :sweep_eng_runs_count

    change_column :users, :administrator, :boolean, default: false

    drop_table :sweep_eng_runs
  end
end
