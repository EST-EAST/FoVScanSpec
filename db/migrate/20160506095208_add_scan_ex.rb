class AddScanEx < ActiveRecord::Migration
  def self.up
    create_table :scan_exes do |t|
      t.string :name
      t.float  :step_size_x
      t.float  :step_number_x
      t.string :step_dir_x
      t.float  :step_size_y
      t.float  :step_number_y
      t.string :step_dir_y
    end

    change_column :fovs, :scans_count, :integer, :null => false, :default => 0

    change_column :windows, :scans_count, :integer, :null => false, :default => 0

    change_column :scan_types, :scans_count, :integer, :null => false, :default => 0

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :fovs, :scans_count, :integer, default: 0, null: false

    change_column :windows, :scans_count, :integer, default: 0, null: false

    change_column :scan_types, :scans_count, :integer, default: 0, null: false

    change_column :users, :administrator, :boolean, default: false

    drop_table :scan_exes
  end
end
