class AddAttendeeCountToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :attendee_count, :integer, :default => 0
  end

  def self.down
    remove_column :events, :attendee_count
  end
end
