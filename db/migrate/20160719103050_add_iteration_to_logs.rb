class AddIterationToLogs < ActiveRecord::Migration
  def self.up
    add_column :scan_ex_logs, :iteration, :integer, :default => 0   # As there was no repetitions, the iteration was 0
    add_column :scan_ex_logs, :step_order, :integer
    ScanExLog.update_all("step_order=step") # As there was no repetitions, the step_order is the step
  end

  def self.down
    remove_column :scan_ex_logs, :step_order
    remove_column :scan_ex_logs, :iteration
  end
end
