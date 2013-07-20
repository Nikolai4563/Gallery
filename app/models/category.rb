class Category < ActiveRecord::Base
  has_many :images
  has_many :subscribes
  has_many :users, through: :subscribes
end