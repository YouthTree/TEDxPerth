# This file is auto-generated from the current state of the database. Instead 
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your 
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100822200515) do

  create_table "banner_items", :force => true do |t|
    t.string   "title",           :null => false
    t.string   "url",             :null => false
    t.text     "description",     :null => false
    t.string   "image"
    t.datetime "published_after"
    t.datetime "published_until"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "banner_items", ["published_after", "published_until"], :name => "index_banner_items_on_published_after_and_published_until"

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "description_format"
    t.text     "description"
    t.text     "rendered_description"
    t.string   "cached_slug"
    t.string   "notes_format"
    t.text     "notes"
    t.text     "rendered_notes"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attendee_count",       :default => 0
    t.integer  "venue_id"
    t.string   "image"
  end

  add_index "events", ["cached_slug"], :name => "index_events_on_cached_slug"

  create_table "ngos", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "url"
    t.string   "cached_slug"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ngos", ["cached_slug"], :name => "index_ngos_on_cached_slug"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "rendered_content"
    t.datetime "published_at"
    t.text     "description"
    t.string   "keywords"
    t.string   "key"
    t.string   "cached_slug"
    t.string   "format"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "menu_subtitle"
    t.string   "menu_title"
    t.integer  "menu_position"
    t.boolean  "show_in_menu",     :default => false
  end

  add_index "pages", ["cached_slug"], :name => "index_pages_on_cached_slug"
  add_index "pages", ["key"], :name => "index_pages_on_key"
  add_index "pages", ["menu_position"], :name => "index_pages_on_menu_position"
  add_index "pages", ["show_in_menu", "menu_position"], :name => "index_pages_on_show_in_menu_and_menu_position"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.datetime "published_at"
    t.text     "rendered_summary"
    t.text     "content"
    t.text     "rendered_content"
    t.string   "format"
    t.string   "preview_key"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["cached_slug", "published_at"], :name => "index_posts_on_cached_slug_and_published_at"
  add_index "posts", ["cached_slug"], :name => "index_posts_on_cached_slug"
  add_index "posts", ["preview_key"], :name => "index_posts_on_preview_key"

  create_table "roles", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "owner_type", "owner_id"], :name => "index_roles_on_name_and_owner_type_and_owner_id"
  add_index "roles", ["name", "owner_type"], :name => "index_roles_on_name_and_owner_type"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rpx_identifiers", :force => true do |t|
    t.string   "identifier",    :null => false
    t.string   "provider_name"
    t.integer  "user_id",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rpx_identifiers", ["identifier"], :name => "index_rpx_identifiers_on_identifier", :unique => true
  add_index "rpx_identifiers", ["user_id"], :name => "index_rpx_identifiers_on_user_id"

  create_table "slugs", :force => true do |t|
    t.string   "scope"
    t.string   "slug"
    t.integer  "record_id"
    t.datetime "created_at"
  end

  add_index "slugs", ["scope", "record_id", "created_at"], :name => "index_slugs_on_scope_and_record_id_and_created_at"
  add_index "slugs", ["scope", "record_id"], :name => "index_slugs_on_scope_and_record_id"
  add_index "slugs", ["scope", "slug", "created_at"], :name => "index_slugs_on_scope_and_slug_and_created_at"
  add_index "slugs", ["scope", "slug"], :name => "index_slugs_on_scope_and_slug"

  create_table "ted_videos", :force => true do |t|
    t.string   "url"
    t.text     "embed_code"
    t.text     "raw_embedly_response"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "role_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["user_id", "role_id"], :name => "index_user_roles_on_user_id_and_role_id"
  add_index "user_roles", ["user_id"], :name => "index_user_roles_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "email"
    t.integer  "login_count"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.string   "display_name"
    t.string   "origin"
    t.string   "perishable_token",  :null => false
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["cached_slug"], :name => "index_users_on_cached_slug"
  add_index "users", ["login"], :name => "index_users_on_login"
  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"
  add_index "users", ["persistence_token"], :name => "index_users_on_persistence_token"

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "location_name"
    t.text     "instructions"
    t.text     "address"
    t.decimal  "lat",           :precision => 15, :scale => 10
    t.decimal  "lng",           :precision => 15, :scale => 10
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venues", ["cached_slug"], :name => "index_venues_on_cached_slug"

end
