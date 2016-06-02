class AddScanengrun < ActiveRecord::Migration
  def self.up
    create_table :scan_eng_runs do |t|
      t.string   :name
      t.float    :max_l1_speed
      t.float    :max_l2_speed
      t.float    :max_l3_speed
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :scan_ex_id
    end
    add_index :scan_eng_runs, [:scan_ex_id]

    change_column :scans, :scan_exes_count, :integer, :null => false, :default => 0

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    add_column :scan_exes, :scan_eng_runs_count, :integer, :default => 0, :null => false

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :scans, :scan_exes_count, :integer, default: 0, null: false

    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    remove_column :scan_exes, :scan_eng_runs_count

    change_column :users, :administrator, :boolean, default: false

    drop_table :scan_eng_runs
  end
end
