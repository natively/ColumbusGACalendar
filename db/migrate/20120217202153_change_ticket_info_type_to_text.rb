class ChangeTicketInfoTypeToText < ActiveRecord::Migration
  def up
    change_column :events, :ticket_info, :text
  end

  def down
    change_column :events, :ticket_info, :string
  end
end
