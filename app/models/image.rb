  class Image < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :likes
  has_many :users, :through => :likes
  belongs_to :category, :counter_cache => true
  mount_uploader :url, ImageUploader
  attr_accessible :url, :category_id
  before_save :send_mail

  def send_mail
    array_user_email = self.category.users.pluck(:email)
    image = self.url
    category = self.category.name

    UserMailer.welcome_email(array_user_email, image, category).deliver
  end
end