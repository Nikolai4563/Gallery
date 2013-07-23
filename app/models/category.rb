# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  images_count :integer          default(0)
#  name         :string(255)
#

class Category < ActiveRecord::Base
  has_many :images ,:dependent => :destroy
  has_many :subscribes
  has_many :users, through: :subscribes

end
