class SessionsController < Devise::SessionsController

  def create
    #expire_fragment 'authorization'
    super
    if user_signed_in?
      ActiveSupport::Notifications.instrument("sessions.create", :user => current_user)
    end
  end

  def destroy
    user = current_user
    super
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    if !user_signed_in?
      ActiveSupport::Notifications.instrument("sessions.destroy", :user => user)
    end
   # expire_fragment 'authorization'
  end
end

