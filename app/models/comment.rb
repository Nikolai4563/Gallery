# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  commentable_id   :integer
#  commentable_type :string(255)
#  image_id         :integer
#  body             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  belongs_to :image, :counter_cache => true
  has_many :events, :as => :eventable, :dependent => :destroy

  attr_accessible :body, :commentable_type, :commentable_id
  validates_presence_of :body,:commentable_type,:commentable_id
end
