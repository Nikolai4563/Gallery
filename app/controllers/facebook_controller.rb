class FacebookController < ApplicationController

  def create
    expire_fragment('layouts-navigation')
    auth = env['omniauth.auth']

    @user = User.find_or_create_by_uid(:uid => auth[:uid], :provider => auth[:provider],
                                       :name => auth[:extra][:raw_info][:name], :password =>  Devise.friendly_token[0,20],
                                       :image => open(auth['info']['image']),
                                       :email => "#{auth[:provider]}@#{auth[:extra][:raw_info][:name].delete ' '}.com")
    @user.update_attribute('image', open(auth['info']['image']))

    if sign_in @user
      Resque.enqueue(SignInEvent, current_user.id)
      #ActiveSupport::Notifications.instrument("sessions.create", :user => current_user)
    end

    redirect_to root_path

  end

end