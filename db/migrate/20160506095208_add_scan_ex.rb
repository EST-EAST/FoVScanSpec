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
  end

  def self.down
    drop_table :scan_exes
  end
end
