#coding: utf-8

class Event < ActiveRecord::Base
  
  belongs_to :event_type
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates_presence_of :user, :event_type, :name, :start_time, :description, :location, :address

  geocoded_by :full_address
  after_validation :geocode
  
  before_create do
    self.permalink = self.name unless self.permalink.present?
  end

  def self.happening
    where("start_time < current_timestamp AND end_time > current_timestamp AND end_time IS NOT NULL").order("start_time DESC")
  end

  def self.upcoming
    where("start_time >= current_timestamp").order(:start_time)
  end

  def self.past
    where("(end_time IS NOT NULL AND end_time < current_timestamp) OR (end_time IS NULL AND start_time < current_timestamp)").order("start_time DESC")
  end
  
  def to_param
    "#{self.id}-#{self.permalink.parameterize}"
  end

  def full_address
    return self.address if self.address.match(/Porto Alegre/i)
    "#{self.address} Porto Alegre".strip
  end

end
