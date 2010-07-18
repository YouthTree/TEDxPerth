class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name, :null => false
      t.belongs_to :owner, :polymorphic => true
      t.timestamps
    end
    add_index :roles, [:name]
    add_index :roles, [:name, :owner_type]
    add_index :roles, [:name, :owner_type, :owner_id]
  end

  def self.down
    drop_table :roles
  end
end
