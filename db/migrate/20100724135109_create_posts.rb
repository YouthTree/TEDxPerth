class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.datetime :published_at
      t.text :rendered_summary
      t.text :content
      t.text :rendered_content
      t.string :format
      t.string :preview_key
      t.string :cached_slug
      t.timestamps
    end
    add_index :posts, :cached_slug
    add_index :posts, [:cached_slug, :published_at]
    add_index :posts, :preview_key
  end

  def self.down
    drop_table :posts
  end
end
