require 'spec_helper'



describe 'User', :type => :feature, :js => true do
  include Warden::Test::Helpers

  context 'some stuff which requires js' do

    before :each do
      Warden.test_mode!
      @user = FactoryGirl.create(:user)
      FactoryGirl.create(:user, :email => 'FactoryGirl@mail.ru', :password=> '123456789', :password_confirmation => '123456789')
      @category = FactoryGirl.create(:category)
      @image = FactoryGirl.create(:image, :category => @category)
      @sign_in = Event.create(:eventable_type => 'Sign_in',:eventable_id => 1, :user_id => @user.id)
    end
    it 'Sign_up User' do
      visit '/'
      click_link 'Sign up'
      fill_in 'Name', :with => 'Nikolai'
      fill_in 'Email', :with => 'Nikolai@mail.ru'
      fill_in 'Password', :with => '123456789'
      fill_in 'Password confirmation', :with => '123456789'
      click_button 'Sign up'
      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
    it 'Sign_in User' do
      visit '/'
      click_link 'Login'
      fill_in 'Email', :with => 'FactoryGirl@mail.ru'
      fill_in 'Password', :with => '123456789'
      click_button 'Sign in'
      expect(page).to have_content 'Signed in successfully.'
    end
  end

end