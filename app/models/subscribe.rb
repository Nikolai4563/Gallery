class Subscribe < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :category_id, :user_id
  validates :category_id, :uniqueness => { :scope => :user_id }
end
