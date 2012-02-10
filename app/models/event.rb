class Event < ActiveRecord::Base
  belongs_to :event_type
  validates_presence_of :facebook_id, :event_type
  validates_uniqueness_of :facebook_id
  
  before_create :get_facebook_data
  
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
