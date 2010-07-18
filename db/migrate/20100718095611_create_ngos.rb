class CreateNgos < ActiveRecord::Migration
  def self.up
    create_table :ngos do |t|
      t.string :name
      t.text :description
      t.string :url
      t.string :cached_slug
      t.string :state
      t.timestamps
    end
    add_index :ngos, :cached_slug
  end

  def self.down
    drop_table :ngos
  end
end
