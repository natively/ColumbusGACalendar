class Event < ActiveRecord::Base
  validates_uniqueness_of :unique_event_id

  has_and_belongs_to_many :groups

  scope :after_today, where('starts_at >= ?', Time.now )
  scope :featured, where('featured = ?', true)

  def self.date_filter(starts, ends)
    if !starts && !ends
      after_today
    elsif !starts.empty? && !ends.empty?
      where 'starts_at >= ? AND ends_at <= ?',
             DateTime.strptime(starts.to_s, '%m/%d/%Y'), 
             DateTime.strptime(ends.to_s, '%m/%d/%Y')
    elsif !starts.empty? && ends.empty?
      where 'starts_at >= ?', DateTime.strptime(starts.to_s, '%m/%d/%Y')
    elsif starts.empty? && !ends.empty?
      where 'starts_at <= ?', DateTime.strptime(ends.to_s, '%m/%d/%Y')
    else
      after_today
    end
  end

  def self.group_filter( group_id )
    unless group_id.nil?
      unless group_id.empty?
        joins(:groups).where("events_groups.group_id = ?", group_id)
      else
        scoped
      end
    else
      scoped
    end
  end

  def self.search(search)
    if search
      where('name ILIKE ? OR description ILIKE ?', "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
end