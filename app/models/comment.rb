class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :image, :counter_cache => true
  has_many :events, :as => :eventable, :dependent => :destroy
  belongs_to :user

  attr_accessible :body, :commentable_type, :commentable_id
  validates_presence_of :body,:commentable_type,:commentable_id
end
