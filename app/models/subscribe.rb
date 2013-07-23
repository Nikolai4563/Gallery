# == Schema Information
#
# Table name: subscribes
#
#  id          :integer          not null, primary key
#  category_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Subscribe < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  attr_accessible :category_id, :user_id
  validates :category_id, :uniqueness => { :scope => :user_id }
end
