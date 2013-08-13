class SignInEvent
  @queue = :sign_ins_queue
  def self.perform(user_id)
    user_sign_in = User.find(user_id)
    ActiveSupport::Notifications.instrument('sessions.create', :user => user_sign_in)
  end
end
