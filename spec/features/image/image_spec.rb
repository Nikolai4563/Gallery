require 'spec_helper'



describe 'Image', :type => :feature, :js => true do
  include Warden::Test::Helpers

  context 'some stuff which requires js' do

    before :each do
      Warden.test_mode!
      user = FactoryGirl.create(:user)
      category = FactoryGirl.create(:category)
      image = FactoryGirl.create(:image, :category => category)
      @sign_in = Event.create(:eventable_type => 'Sign_in',:eventable_id => 1, :user_id => user.id)
      login_as(user, :scope => :user, :run_callbacks => false)
    end

    after :each do
      logout(:user)
      Warden.test_reset!
    end


    it 'Sign_up User' do
      visit '/'
      click_link 'image-1'
      sleep(2)
      first(:css,'.likes').click
      within("#new_comment") do
        fill_in 'comment_body', :with => 'My comment'
      end
      click_button('Add comment')
      expect(page).to have_content 'My comment'
    end
    #it 'Sign_in User' do
    #  visit '/'
    #  click_link 'Login'
    #  fill_in 'Email', :with => 'FactoryGirl@mail.ru'
    #  fill_in 'Password', :with => '123456789'
    #  click_button 'Sign in'
    #  expect(page).to have_content 'Signed in successfully.'
    #end
  end

end