# == Schema Information
#
# Table name: navigations
#
#  id            :integer          not null, primary key
#  path          :string(255)
#  page_duration :float
#  view_duration :float
#  db_duration   :float
#

class Navigation < ActiveRecord::Base

  has_many :events, :as => :eventable, :dependent => :destroy


end
