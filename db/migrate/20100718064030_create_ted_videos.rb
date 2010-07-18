class CreateTedVideos < ActiveRecord::Migration
  def self.up
    create_table :ted_videos do |t|
      t.string :url
      t.text :embed_code
      t.text :raw_embedly_response
      t.belongs_to :event
      t.timestamps
    end
  end

  def self.down
    drop_table :ted_videos
  end
end
