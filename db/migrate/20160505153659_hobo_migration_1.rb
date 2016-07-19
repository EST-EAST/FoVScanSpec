class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :scans do |t|
      t.boolean  :double_sampling
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :scans
  end
end
