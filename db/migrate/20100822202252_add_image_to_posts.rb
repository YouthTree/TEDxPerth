class AddImageToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :image, :string
  end

  def self.down
    remove_column :posts, :image
  end
end
