class Event < ActiveRecord::Base
  belongs_to :event_type
  validates_presence_of :facebook_id, :event_type
  validates_uniqueness_of :facebook_id
  
  before_create :get_facebook_data
  
  scope :happening, where("start_time < current_timestamp AND end_time > current_timestamp").order("start_time DESC")
  scope :upcoming, where("start_time >= current_timestamp").order(:start_time)
  scope :past, where("end_time < current_timestamp").order("end_time DESC")
  
  def url
    "http://www.facebook.com/events/#{facebook_id}/"
  end
  
  private
  
  def get_facebook_data
    data = JSON.parse(HTTParty.get("https://graph.facebook.com/#{self.facebook_id}").body)
    self.name = data["name"] unless self.name.present?
    self.start_time = data["start_time"] unless self.start_time.present?
    self.end_time = data["end_time"] unless self.end_time.present?
    self.location = data["location"] unless self.location.present?
    self.picture = HTTParty.get("https://graph.facebook.com/#{self.facebook_id}/picture?type=large", follow_redirects: false).headers["location"] unless self.picture.present?
  end
  
end
