class AddRawUnitsToFovAttributes < ActiveRecord::Migration
  def self.up
    add_column :fovs, :raw_units, :boolean, :default => false
  end

  def self.down
    remove_column :fovs, :raw_units
  end
end
