class Navigation < ActiveRecord::Base

  has_many :events, :as => :eventable, :dependent => :destroy


end
