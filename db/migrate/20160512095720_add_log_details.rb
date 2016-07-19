class AddLogDetails < ActiveRecord::Migration
  def self.up
    add_column :scan_ex_logs, :step, :integer
    add_column :scan_ex_logs, :x, :integer
    add_column :scan_ex_logs, :y, :integer
    add_column :scan_ex_logs, :x_coord, :float
    add_column :scan_ex_logs, :y_coord, :float
    add_column :scan_ex_logs, :timestr, :string
    add_column :scan_ex_logs, :dtinit, :datetime
    add_column :scan_ex_logs, :dtend, :datetime
  end

  def self.down
    remove_column :scan_ex_logs, :step
    remove_column :scan_ex_logs, :x
    remove_column :scan_ex_logs, :y
    remove_column :scan_ex_logs, :x_coord
    remove_column :scan_ex_logs, :y_coord
    remove_column :scan_ex_logs, :timestr
    remove_column :scan_ex_logs, :dtinit
    remove_column :scan_ex_logs, :dtend
  end
end
