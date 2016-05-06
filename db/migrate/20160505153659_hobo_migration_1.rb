class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :sweeps do |t|
      t.boolean  :double_sampling
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    drop_table :sweeps
  end
end
