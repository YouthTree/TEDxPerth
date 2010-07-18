class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users, :force => true do |t|
      t.string   :login
      t.string   :crypted_password
      t.string   :password_salt
      t.string   :persistence_token
      t.string   :email
      t.integer  :login_count
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string   :last_login_ip
      t.string   :current_login_ip
      t.string   :display_name
      t.string   :origin
      t.string   :perishable_token, :null => false
      t.string   :cached_slug
      t.timestamps
    end
    add_index :users, [:cached_slug],       :name => "index_users_on_cached_slug"
    add_index :users, [:login],             :name => "index_users_on_login"
    add_index :users, [:perishable_token],  :name => "index_users_on_perishable_token"
    add_index :users, [:persistence_token], :name => "index_users_on_persistence_token"
  end

  def self.down
    drop_table :users
  end
end
