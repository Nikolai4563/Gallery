class SignOutEvent
  @queue = :sign_outs_queue
  def self.perform(user_id)
    user = User.find(user_id)
    ActiveSupport::Notifications.instrument("sessions.destroy", :user => user)
  end
end
