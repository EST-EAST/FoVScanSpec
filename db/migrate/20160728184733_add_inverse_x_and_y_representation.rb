class AddInverseXAndYRepresentation < ActiveRecord::Migration
  def self.up
    add_column :fovs, :inverse_x, :boolean, :default => false
    add_column :fovs, :inverse_y, :boolean, :default => false
  end

  def self.down
    remove_column :fovs, :inverse_x
    remove_column :fovs, :inverse_y
  end
end
