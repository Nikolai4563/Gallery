class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :image, :counter_cache => true
  has_many :events, :as => :eventable, :dependent => :destroy
  attr_accessible :image_id
  validates :image_id, :uniqueness => { :scope => :user_id }




end