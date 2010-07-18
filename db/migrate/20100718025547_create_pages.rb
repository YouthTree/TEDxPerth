class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string   :title
      t.text     :content
      t.text     :rendered_content
      t.datetime :published_at
      t.text     :description
      t.string   :keywords
      t.string   :key
      t.string   :cached_slug
      t.string   :format
      t.timestamps
    end
    add_index :pages, :key
    add_index :pages, :cached_slug
  end

  def self.down
    drop_table :pages
  end
end
