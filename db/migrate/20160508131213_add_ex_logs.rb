class AddExLogs < ActiveRecord::Migration
  def self.up
    create_table :scan_ex_logs do |t|
      t.float    :a
      t.float    :b
      t.float    :c
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :scan_eng_run_id
    end
    add_index :scan_ex_logs, [:scan_eng_run_id]

    add_column :scan_eng_runs, :scan_ex_logs_count, :integer, :default => 0, :null => false

  end

  def self.down
    remove_column :scan_eng_runs, :scan_ex_logs_count

    drop_table :scan_ex_logs
  end
end
