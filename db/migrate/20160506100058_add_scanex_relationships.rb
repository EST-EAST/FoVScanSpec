class AddScanexRelationships < ActiveRecord::Migration
  def self.up
    add_column :scan_exes, :step_init_coord, :string
    add_column :scan_exes, :step_init_x, :float
    add_column :scan_exes, :step_init_y, :float
    add_column :scan_exes, :repetitions, :integer
    add_column :scan_exes, :created_at, :datetime
    add_column :scan_exes, :updated_at, :datetime
    add_column :scan_exes, :scan_id, :integer

    add_index :scan_exes, [:scan_id]
  end

  def self.down
    remove_column :scan_exes, :step_init_coord
    remove_column :scan_exes, :step_init_x
    remove_column :scan_exes, :step_init_y
    remove_column :scan_exes, :repetitions
    remove_column :scan_exes, :created_at
    remove_column :scan_exes, :updated_at
    remove_column :scan_exes, :scan_id

    remove_index :scan_exes, :name => :index_scan_exes_on_scan_id rescue ActiveRecord::StatementInvalid
  end
end
