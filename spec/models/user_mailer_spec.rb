require 'spec_helper'

describe UserMailer do
  describe 'welcome_email' do
    before :each do
      @category = FactoryGirl.create(:category)
      @user = FactoryGirl.create(:user)
      @user2 = FactoryGirl.create(:user)
      @category.users << @user
      @category.users << @user2
      @array = @category.users.pluck(:email)

      @image = FactoryGirl.create(:image, :category => @category)
      @mail = UserMailer.welcome_email(@array,@image,@category)
    end


    #ensure that the subject is correct
    it 'renders the subject' do
      @mail.subject.should == 'Welcome to My Awesome Site'
    end

    #ensure that the receiver is correct
    it 'renders the receiver email' do
      @mail.to.should == [@user2.email]
    end

    #ensure that the sender is correct
    it 'renders the sender email' do
      @mail.from.should == ['pecenevnikolai@gmail.com']
    end

  end
end