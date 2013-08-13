class CommentEvent
  @queue = :comments_queue
  def self.perform(comment_id)
    comment = Comment.find(comment_id)
    ActiveSupport::Notifications.instrument('comments.create', :comment => comment)
  end
end