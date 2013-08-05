require 'spec_helper'

describe CommentsController do
  before :each do
    @category = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    @category.users << @user
    @image = FactoryGirl.create(:image, :category => @category)
  end
  describe "routes" do
    it "route to #new" do
      expect(:get => "/images/1/comments/new").to route_to(:action => "new", :controller => "comments", :image_id => "1")
    end
    it "route to #create" do
      expect(:post => "/images/1/comments").to route_to(:action => "create", :controller => "comments", :image_id => "1")
    end
  end
  describe 'Create' do
    it "creates a new comment" do
      sign_in @user
      expect{
        post :create,{:image_id => 1, :comment => {:body=>"123123123"}}
      }.to change(Comment,:count).by(1)
    end

    it "does not save the new comennt" do
      sign_in @user
      expect{
        post :create,{:image_id => 1, :comment => {:body=>nil}}
      }.to change(Comment,:count).by(0)
    end
    it "Unauthorized" do
      post :create,{:image_id => 1, :comment => {:body=>"123123123"}}
      response.should redirect_to(new_user_session_path)
    end

  end
end
