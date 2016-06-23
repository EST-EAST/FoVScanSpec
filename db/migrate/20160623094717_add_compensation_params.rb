class AddCompensationParams < ActiveRecord::Migration
  def self.up
    add_column :scan_eng_runs, :comp_factor_x, :float, :default => 1.0
    add_column :scan_eng_runs, :comp_factor_y, :float, :default => 1.0
    add_column :scan_eng_runs, :comp_divisor, :float, :default => 2.0
  end

  def self.down
    remove_column :scan_eng_runs, :comp_factor_x
    remove_column :scan_eng_runs, :comp_factor_y
    remove_column :scan_eng_runs, :comp_divisor
  end
end
