class AddAdditionalInfoToEventsTable < ActiveRecord::Migration
  def self.up
    add_column :events, :ticket_info, :string
    add_column :events, :ticket_prices, :string

    add_column :events, :additional_info, :string
    
    add_column :events, :contact_name, :string
    add_column :events, :contact_email, :string
    add_column :events, :contact_phone, :string
  end

  def self.down
    remove_column :events, :ticket_info
    remove_column :events, :ticket_prices

    remove_column :events, :additional_info
    
    remove_column :events, :contact_name
    remove_column :events, :contact_email
    remove_column :events, :contact_phone
  end
end
