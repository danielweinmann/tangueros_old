#coding: utf-8

class Event < ActiveRecord::Base
  
  default_scope { select("*, events.next_starts_at::timestamptz AS next_starts_at, events.next_ends_at::timestamptz AS next_ends_at") }

  belongs_to :event_type
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates_presence_of :user, :event_type, :name, :starts_at, :location

  geocoded_by :full_address
  after_validation :geocode
  
  before_create do
    self.permalink = self.name unless self.permalink.present?
  end

  def self.happening
    where("events.next_starts_at < now() AND events.next_ends_at > now() AND events.next_ends_at IS NOT NULL").order("events.next_starts_at DESC")
  end

  def self.upcoming
    where("events.next_starts_at >= now()").order(:starts_at)
  end

  def self.past
    where("(events.next_ends_at IS NOT NULL AND events.next_ends_at < now()) OR (events.next_ends_at IS NULL AND events.next_starts_at < now())").order("events.next_starts_at DESC")
  end
  
  def to_param
    "#{self.id}-#{self.permalink.parameterize}"
  end

  def next_starts_at
    self.attributes["next_starts_at"].try(:localtime)
  end

  def next_ends_at
    self.attributes["next_ends_at"].try(:localtime)
  end

  def full_address
    return self.address if self.address && self.address.match(/Porto Alegre/i)
    "#{self.address} Porto Alegre".strip
  end

end
