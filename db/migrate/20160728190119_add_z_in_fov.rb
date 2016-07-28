class AddZInFov < ActiveRecord::Migration
  def self.up
    add_column :fovs, :size_z, :float
    add_column :fovs, :zero_z, :float, :default => nil
    add_column :fovs, :inverse_z, :boolean, :default => false
  end

  def self.down
    remove_column :fovs, :size_z
    remove_column :fovs, :zero_z
    remove_column :fovs, :inverse_z
  end
end
