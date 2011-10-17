class Event < ActiveRecord::Base
  validates_uniqueness_of :unique_event_id

  has_and_belongs_to_many :groups

  scope :after_today, where('starts_at >= ?', Time.now )
  scope :featured, where('featured = ?', true)

  def self.date_filter(starts, ends)
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

  def self.group_filter(arg={})
    unless arg.nil?
      unless arg[:group_id].empty?
        puts 'Finding by group id'
        g_id = arg['group_id']
        joins(:groups).where("events_groups.group_id = ?", g_id)
      end
      scoped
    else
      puts 'Scoped!'
      scoped
    end
  end

  def self.search(search)
    if search
      where('name ILIKE ?', "%#{search}%")
    else
      scoped
    end
  end
end