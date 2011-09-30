class Event < ActiveRecord::Base
  validates_uniqueness_of :unique_event_id

  scope :after_today, where('starts_at > ?', Time.now )
  scope :featured, where('featured = ?', true)

  def self.datefilter(starts, ends)
    if !starts && !ends
      after_today
    elsif !starts.empty? && !ends.empty?
      where 'starts_at > ? AND ends_at < ?',
             DateTime.strptime(starts.to_s, '%m/%d/%Y'), 
             DateTime.strptime(ends.to_s, '%m/%d/%Y')
    elsif !starts.empty? && ends.empty?
      where 'starts_at > ?', DateTime.strptime(starts.to_s, '%m/%d/%Y')
    elsif starts.empty? && !ends.empty?
      where 'starts_at < ?', DateTime.strptime(ends.to_s, '%m/%d/%Y')
    else
      after_today
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      Event.all
    end
  end
end