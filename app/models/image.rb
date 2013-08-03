# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  category_id    :integer
#  likes_count    :integer          default(0)
#  comments_count :integer          default(0)
#  url            :string(255)
#

  class Image < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :likes
  has_many :users, :through => :likes
  belongs_to :category, :counter_cache => true
  mount_uploader :url, ImageUploader
  attr_accessible :url, :category_id, :title
  before_save :send_mail

  validates :url, :presence => true
  validates :category_id, :presence => true

  def send_mail
    array_user_email = self.category.users.pluck(:email)
    image = self.url
    category = self.category.name
    if !array_user_email.blank?
      UserMailer.welcome_email(array_user_email, image, category).deliver
    end
  end
end
