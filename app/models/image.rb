class Image < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :likes
  has_many :users, :through => :likes
  belongs_to :category, :counter_cache => true
  mount_uploader :url, ImageUploader
  attr_accessible :url
end