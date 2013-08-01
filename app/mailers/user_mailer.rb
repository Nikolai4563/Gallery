class UserMailer < ActionMailer::Base
  default from: 'pecenevnikolai@gmail.com'

  def welcome_email(emails, image, category)
    @image = image
    @category = category
    emails.each do |email|
      mail(:to => email, subject: 'Welcome to My Awesome Site')
    end
  end
end
