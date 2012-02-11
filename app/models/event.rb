#coding: utf-8

FB_REGEX = /\Ahttp:\/\/www.facebook.com\/events\/(\d+)\/{0,1}/

class Event < ActiveRecord::Base
  
  extend ActiveSupport::Memoizable
  
  belongs_to :event_type
  validates_presence_of :url, :event_type
  validates_uniqueness_of :url
  validates_format_of :url, with: FB_REGEX, :message => "deve ser uma URL de evento do Facebook válida"
  validate :must_have_facebook_data
  
  before_create :get_facebook_data
  
  scope :happening, where("start_time < current_timestamp AND end_time > current_timestamp").order("start_time DESC")
  scope :upcoming, where("start_time >= current_timestamp").order(:start_time)
  scope :past, where("end_time < current_timestamp").order("end_time DESC")
  
  def facebook_id
    self.url.match(FB_REGEX)[1]
  end
  memoize :facebook_id
  
  private
  
  def must_have_facebook_data
    raise unless self.url.present? and self.url.match(FB_REGEX)
    data = JSON.parse(HTTParty.get("https://graph.facebook.com/#{self.facebook_id}").body)
    raise unless data["name"]
    raise unless data["start_time"]
    raise unless data["end_time"]
    raise unless data["location"]
  rescue
    errors.add(:url, "não é um evento aberto do Facebook")
  end
  
  def get_facebook_data
    data = JSON.parse(HTTParty.get("https://graph.facebook.com/#{self.facebook_id}").body)
    self.name = data["name"] unless self.name.present?
    self.start_time = data["start_time"] unless self.start_time.present?
    self.end_time = data["end_time"] unless self.end_time.present?
    self.location = data["location"] unless self.location.present?
    self.picture = HTTParty.get("https://graph.facebook.com/#{self.facebook_id}/picture?type=large", follow_redirects: false).headers["location"] unless self.picture.present?
  end
  
end
