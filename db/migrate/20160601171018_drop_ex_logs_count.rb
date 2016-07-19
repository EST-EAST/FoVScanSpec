class DropExLogsCount < ActiveRecord::Migration
  def self.up
    remove_column :scan_eng_runs, :scan_ex_logs_count
  end

  def self.down
    add_column :scan_eng_runs, :scan_ex_logs_count, :integer, default: 0, null: false
  end
end
