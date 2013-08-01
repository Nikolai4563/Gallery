#ActiveSupport::Notifications.subscribe do |name, start, sinish, id, payload|
#  Rails.logger.debug(["notification:",name, start, sinish, id, payload].join(" "))
#end

ActiveSupport::Notifications.subscribe "likes.create" do |name, start, finish, id, payload|
  Event.create(:eventable => payload[:like], :user_id => payload[:like].user_id)
end

ActiveSupport::Notifications.subscribe "comments.create" do |name, start, finish, id, payload|
  Event.create(:eventable => payload[:comment], :user_id => payload[:comment].commentable.id)
end

ActiveSupport::Notifications.subscribe "sessions.create" do |name, start, finish, id, payload|
  Event.create(:eventable_type => 'Sign_in', :user_id => payload[:user].id, :eventable_id => payload[:user].id )
end
ActiveSupport::Notifications.subscribe "sessions.destroy" do |name, start, finish, id, payload|
  Event.create(:eventable_type => 'Sign_out', :user_id => payload[:user].id, :eventable_id => payload[:user].id )
end
ActiveSupport::Notifications.subscribe "sessions.destroy" do |name, start, finish, id, payload|
  Event.create(:eventable_type => 'Sign_out', :user_id => payload[:user].id, :eventable_id => payload[:user].id )
end


ActiveSupport::Notifications.subscribe "process_action.action_controller" do |name, start, finish, id, payload|
  if payload[:uid]
    if (payload[:path].length < 255 )
      nav =  Navigation.find_or_create_by_path(payload[:path])
      Event.create(:eventable_type => 'Navigation', :user_id => payload[:uid], :eventable_id => nav.id )
    end

  end

end
