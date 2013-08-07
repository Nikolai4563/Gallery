require 'spec_helper'



describe 'Image', :type => :feature, :js => true do
  include Warden::Test::Helpers

  context 'some stuff which requires js' do

    before :each do
      Warden.test_mode!
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category)
      @image = FactoryGirl.create(:image, :category => @category)
      @sign_in = Event.create(:eventable_type => 'Sign_in',:eventable_id => 1, :user_id => @user.id)
    end
    it 'Show image' do
      visit '/'
      click_link 'image-1'
      expect(page).to have_content 'Comments'
    end

  end

end