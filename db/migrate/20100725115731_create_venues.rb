class CreateVenues < ActiveRecord::Migration
  def self.up
    create_table :venues do |t|
      t.string :name
      t.string :location_name
      t.text :instructions
      t.text :address
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10
      t.string :cached_slug
      t.timestamps
    end
    add_index :venues, :cached_slug
  end

  def self.down
    drop_table :venues
  end
end
