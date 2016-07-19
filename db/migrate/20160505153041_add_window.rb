class AddWindow < ActiveRecord::Migration
  def self.up
    create_table :windows do |t|
      t.string   :name
      t.float    :size_x
      t.float    :size_y
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :windows
  end
end
