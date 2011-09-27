class Event < ActiveRecord::Base
  validates_uniqueness_of :unique_event_id
end
