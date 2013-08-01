# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  images_count :integer          default(0)
#  name         :string(255)
#

class Category < ActiveRecord::Base
  attr_accessible :name

  has_many :images
  has_many :subscribes
  has_many :users, through: :subscribes

  validates :name, :presence => true, :uniqueness => true
end
