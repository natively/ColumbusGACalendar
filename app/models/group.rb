class Group < ActiveRecord::Base
  has_and_belongs_to_many :events
  validates_uniqueness_of :id
end
