class AddFieldsToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :menu_subtitle, :string
    add_column :pages, :menu_title, :string
    add_column :pages, :menu_position, :integer
    add_column :pages, :show_in_menu, :boolean, :default => false
    add_index :pages, :menu_position
    add_index :pages, [:show_in_menu, :menu_position]
  end

  def self.down
    remove_column :pages, :show_in_menu
    remove_column :pages, :menu_position
    remove_column :pages, :menu_subtitle
    remove_column :pages, :menu_title
  end
end
