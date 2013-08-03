require 'spec_helper'

describe LikesController do
  describe "Create" do
    before :each do
      @category = FactoryGirl.create(:category)
      @user = FactoryGirl.create(:user)
      @category.users << @user
      @image = FactoryGirl.create(:image, :category => @category)
    end
    it "Unauthorized" do
      sign_in @user
      post :create, {:image_id => @image}
      response.status.should == 200
    end


  end
end