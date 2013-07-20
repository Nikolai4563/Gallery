class Event < ActiveRecord::Base
  belongs_to :eventable, :polymorphic => true
  belongs_to :user

  attr_accessible :eventable, :user_id, :eventable_type, :eventable_id
end
