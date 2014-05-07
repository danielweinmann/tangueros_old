#coding: utf-8

class Event < ActiveRecord::Base
  
  belongs_to :event_type
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates_presence_of :user, :event_type, :name, :starts_at, :description, :location, :address

  geocoded_by :full_address
  after_validation :geocode
  
  before_create do
    self.permalink = self.name unless self.permalink.present?
  end

  def self.happening
    where("starts_at < current_timestamp AND ends_at > current_timestamp AND ends_at IS NOT NULL").order("starts_at DESC")
  end

  def self.upcoming
    where("starts_at >= current_timestamp").order(:starts_at)
  end

  def self.past
    where("(ends_at IS NOT NULL AND ends_at < current_timestamp) OR (ends_at IS NULL AND starts_at < current_timestamp)").order("starts_at DESC")
  end
  
  def to_param
    "#{self.id}-#{self.permalink.parameterize}"
  end

  def full_address
    return self.address if self.address.match(/Porto Alegre/i)
    "#{self.address} Porto Alegre".strip
  end

end
