class AddColumnsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :unique_event_id, :integer
    add_index :events, :unique_event_id, :unique => true
  end

  def self.down
    remove_column :events, :unique_event_id
  end
end
