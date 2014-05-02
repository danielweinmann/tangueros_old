#coding: utf-8

FB_REGEX = /\Ahttps{0,1}:\/\/www.facebook.com\/events\/(\d+)\/{0,1}/

class Event < ActiveRecord::Base
  
  belongs_to :event_type
  belongs_to :user
  validates_presence_of :url, :event_type
  validates_uniqueness_of :url
  validates_format_of :url, with: FB_REGEX, :message => "deve ser uma URL de evento do Facebook válida"
  validate :must_have_facebook_data
  
  before_create do
    self.set_facebook_data
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

  def facebook_id
    self.url.match(FB_REGEX)[1]
  end

  def facebook_data
    return nil unless self.url.present? and self.url.match(FB_REGEX)
    access_token = HTTParty.get("https://graph.facebook.com/oauth/access_token?client_id=#{ENV['FACEBOOK_APP_ID']}&client_secret=#{ENV['FACEBOOK_APP_SECRET']}&grant_type=client_credentials").body.match(/access_token=(.+)/)[1]
    data = JSON.parse(HTTParty.get("https://graph.facebook.com/#{self.facebook_id}?access_token=#{URI::escape(access_token)}").body)
    return nil unless data["name"]
    return nil unless data["description"]
    return nil unless data["start_time"]
    return nil unless data["location"]
    unless data["cover"]
      cover_data = JSON.parse(HTTParty.get("https://graph.facebook.com/fql?q=#{URI::escape('SELECT pic_cover FROM event WHERE eid=')}#{self.facebook_id}&access_token=#{URI::escape(access_token)}").body)
      cover_id = cover_data["data"][0]["pic_cover"]["cover_id"] if cover_data["data"][0]["pic_cover"]
      if cover_id
        cover = JSON.parse(HTTParty.get("https://graph.facebook.com/#{cover_id}?access_token=#{URI::escape(access_token)}").body)
        width = 0
        cover_index = 0
        cover["images"].each_with_index do |image, index|
          if image["width"] > width
            width = image["width"]
            cover_index = index
          end
        end
        data["cover"] = cover["images"][cover_index]
      end
    end
    data
  end
  
  def update_facebook_data!
    self.name = self.facebook_data["name"]
    self.description = self.facebook_data["description"]
    self.start_time = self.facebook_data["start_time"]
    self.end_time = self.facebook_data["end_time"]
    self.location = self.facebook_data["location"]
    self.picture = self.facebook_data["cover"]["source"] if self.facebook_data["cover"]
    self.picture_width = self.facebook_data["cover"]["width"] if self.facebook_data["cover"]
    self.picture_height = self.facebook_data["cover"]["height"] if self.facebook_data["cover"]
    self.address = self.facebook_data["venue"]["street"] if self.facebook_data["venue"]
    self.latitude = self.facebook_data["venue"]["latitude"] if self.facebook_data["venue"]
    self.longitude = self.facebook_data["venue"]["longitude"] if self.facebook_data["venue"]
    self.save
  end

  def picture_margin
    return 0 unless self.picture_width && self.picture_height
    display_height = (960.0 / self.picture_width * self.picture_height).to_i
    ((display_height - 360) / 2.6 * -1).to_i
  end

  private
  
  def must_have_facebook_data
    errors.add(:url, "não é um evento aberto do Facebook") unless self.facebook_data
  end
  
  def set_facebook_data
    self.name = self.facebook_data["name"] unless self.name.present?
    self.description = self.facebook_data["description"] unless self.description.present?
    self.start_time = self.facebook_data["start_time"] unless self.start_time.present?
    self.end_time = self.facebook_data["end_time"] unless self.end_time.present?
    self.location = self.facebook_data["location"] unless self.location.present?
    self.picture = self.facebook_data["cover"]["source"] unless self.picture.present? || self.facebook_data["cover"].nil?
    self.picture_width = self.facebook_data["cover"]["width"] unless self.picture_width.present? || self.facebook_data["cover"].nil?
    self.picture_height = self.facebook_data["cover"]["height"] unless self.picture_height.present? || self.facebook_data["cover"].nil?
    self.address = self.facebook_data["venue"]["street"] unless self.address.present? || self.facebook_data["venue"].nil?
    self.latitude = self.facebook_data["venue"]["latitude"] unless self.latitude.present? || self.facebook_data["venue"].nil?
    self.longitude = self.facebook_data["venue"]["longitude"] unless self.longitude.present? || self.facebook_data["venue"].nil?
  end
  
end
