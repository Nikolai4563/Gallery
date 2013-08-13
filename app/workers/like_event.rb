class LikeEvent
  @queue = :likes_queue
  def self.perform(like_id)
    like = Like.find(like_id)
    ActiveSupport::Notifications.instrument('likes.create', :like => like)
  end
end