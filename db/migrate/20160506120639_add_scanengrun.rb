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

    add_column :scan_exes, :scan_eng_runs_count, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :scan_exes, :scan_eng_runs_count

    drop_table :scan_eng_runs
  end
end
