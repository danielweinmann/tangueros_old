class User < ActiveRecord::Base

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: ActionController::Base.helpers.asset_path('user.svg')
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :events

  before_create do
    self.name = self.email.match(/(.+)@/)[1] unless self.name.present?
  end

end
