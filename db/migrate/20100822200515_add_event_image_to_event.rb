class AddEventImageToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :image, :string
  end

  def self.down
    remove_column :events, :image
  end
end
