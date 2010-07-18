class CreateUserRoles < ActiveRecord::Migration
  def self.up
    create_table :user_roles do |t|
      t.belongs_to :user, :null => false
      t.belongs_to :role, :null => false
      t.timestamps
    end
    add_index :user_roles, [:user_id]
    add_index :user_roles, [:user_id, :role_id]
  end

  def self.down
    drop_table :user_roles
  end
end
