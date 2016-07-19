class AddScanTypesClasses < ActiveRecord::Migration
  def self.up
    create_table :raster_scan_types do |t|
      t.datetime :created_at
      t.datetime :updated_at
    end

    add_column :scan_types, :type, :string
    add_index :scan_types, [:type]
  end

  def self.down
    remove_column :scan_types, :type

    drop_table :raster_scan_types

    remove_index :scan_types, :name => :index_scan_types_on_type rescue ActiveRecord::StatementInvalid
  end
end
