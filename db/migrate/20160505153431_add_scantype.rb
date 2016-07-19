class AddScantype < ActiveRecord::Migration
  def self.up
    create_table :scan_types do |t|
      t.string   :name
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :scan_types
  end
end
