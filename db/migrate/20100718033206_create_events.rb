class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :description_format
      t.text :description
      t.text :rendered_description
      t.string :cached_slug
      t.string :notes_format
      t.text :notes
      t.text :rendered_notes
      t.string :state
      t.timestamps
    end
    add_index :events, :cached_slug
  end

  def self.down
    drop_table :events
  end
end
