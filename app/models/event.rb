class Event < ActiveRecord::Base
  validates_uniqueness_of :unique_event_id

  named_scope :after_today, where('starts_at > ?', Time.now )
  named_scope :featured, where('featured = ?', true)
end
