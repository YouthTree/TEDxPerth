class CreateBannerItems < ActiveRecord::Migration
  def self.up
    create_table :banner_items do |t|
      t.string :title, :null => false
      t.string :url, :null => false
      t.text :description, :null => false
      t.string :image
      t.datetime :published_after
      t.datetime :published_until
      t.timestamps
    end
    add_index :banner_items, [:published_after, :published_until]
  end

  def self.down
    drop_table :banner_items
  end
end
