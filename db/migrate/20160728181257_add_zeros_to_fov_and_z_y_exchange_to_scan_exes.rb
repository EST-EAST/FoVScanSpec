class AddZerosToFovAndZYExchangeToScanExes < ActiveRecord::Migration
  def self.up
    add_column :scan_exes, :z_y_exchange, :boolean, :default => false
    add_column :fovs, :zero_x, :float, :default => nil
    add_column :fovs, :zero_y, :float, :default => nil
  end

  def self.down
    remove_column :scan_exes, :z_y_exchange
    remove_column :fovs, :zero_x
    remove_column :fovs, :zero_y
  end
end
