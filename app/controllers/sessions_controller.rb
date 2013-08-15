class SessionsController < Devise::SessionsController

  def create
    expire_fragment('layouts-navigation')
    super
    if user_signed_in?
      Resque.enqueue(SignInEvent, current_user.id)
    end
  end

  def destroy
    expire_fragment('layouts-navigation')
    user = current_user
    super
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    if !user_signed_in?
      Resque.enqueue(SignOutEvent, user.id)
    end
  end
end

