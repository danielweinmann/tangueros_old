#coding: utf-8

FB_REGEX = /\Ahttps{0,1}:\/\/www.facebook.com\/events\/(\d+)\/{0,1}/

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

  def facebook_data
    return nil unless self.url.present? and self.url.match(FB_REGEX)
    access_token = HTTParty.get("https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&client_secret=#{ENV['FACEBOOK_APP_SECRET']}&grant_type=client_credentials").body.match(/access_token=(.+)/)[1]
    data = JSON.parse(HTTParty.get("https://graph.facebook.com/#{self.facebook_id}?access_token=#{URI::escape(access_token)}").body)
    return nil unless data["name"]
    return nil unless data["start_time"]
    return nil unless data["location"]
    data
  end
  memoize :facebook_data
  
  private
  
  def must_have_facebook_data
    errors.add(:url, "não é um evento aberto do Facebook") unless self.facebook_data
  end
  
  def get_facebook_data
    self.name = self.facebook_data["name"] unless self.name.present?
    self.start_time = self.facebook_data["start_time"] unless self.start_time.present?
    self.end_time = self.facebook_data["end_time"] unless self.end_time.present?
    self.location = self.facebook_data["location"] unless self.location.present?
    self.picture = HTTParty.get("https://graph.facebook.com/#{self.facebook_id}/picture?type=large", follow_redirects: false).headers["location"] unless self.picture.present?
  end
  
end
