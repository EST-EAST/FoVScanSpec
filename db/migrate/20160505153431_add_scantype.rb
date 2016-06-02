class AddScantype < ActiveRecord::Migration
  def self.up
    create_table :scan_types do |t|
      t.string   :name
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    drop_table :scan_types
  end
end
