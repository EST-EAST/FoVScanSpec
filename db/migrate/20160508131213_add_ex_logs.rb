class AddExLogs < ActiveRecord::Migration
  def self.up
    create_table :sweep_ex_logs do |t|
      t.float    :a
      t.float    :b
      t.float    :c
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :sweep_eng_run_id
    end
    add_index :sweep_ex_logs, [:sweep_eng_run_id]

    add_column :sweep_eng_runs, :sweep_ex_logs_count, :integer, :default => 0, :null => false

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, :null => false, :default => 0

    change_column :sweeps, :sweep_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :sweeps_count, :integer, :null => false, :default => 0

    change_column :windows, :sweeps_count, :integer, :null => false, :default => 0

    change_column :sweep_types, :sweeps_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :sweep_eng_runs, :sweep_ex_logs_count

    change_column :sweep_exes, :sweep_eng_runs_count, :integer, default: 0, null: false

    change_column :sweeps, :sweep_exes_count, :integer, default: 0, null: false

    change_column :fovs, :sweeps_count, :integer, default: 0, null: false

    change_column :windows, :sweeps_count, :integer, default: 0, null: false

    change_column :sweep_types, :sweeps_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    drop_table :sweep_ex_logs
  end
end
