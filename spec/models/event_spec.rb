require 'spec_helper'
describe Event do
  before :each do
    @category = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    @category.users << @user
    @image = FactoryGirl.create(:image, :category => @category)
    @like = Like.create( :image_id => @image.id)
    @comment = FactoryGirl.create(:comment_user, :image => @image)

  end

  it { should belong_to(:eventable) }
  it { should belong_to(:user) }

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:eventable_id).of_type(:integer)}
  it {have_db_column(:eventable_type).of_type(:string)}
  it {have_db_column(:user_id).of_type(:integer)}
  it {have_db_column(:created_at).of_type(:datetime)}

  it { should allow_mass_assignment_of(:eventable_type) }
  it { should allow_mass_assignment_of(:eventable_id) }
  it { should allow_mass_assignment_of(:user_id) }

  it "Event Sign_in" do
    event = Event.create(:eventable_type => 'Sign_in', :user_id => @user.id)
    event.eventable_type.should == 'Sign_in'
    end
  it "Event Sign_out" do
    event = Event.create(:eventable_type => 'Sign_out', :user_id => @user.id)
    event.eventable_type.should == 'Sign_out'
  end
  it "Event Like" do
    event = Event.create(:eventable_type => 'Like', :user_id => @user.id)
    event.eventable_type.should == @like.class.to_s
  end
  it "Event Comment" do
    event = Event.create(:eventable_type => 'Comment', :user_id => @user.id)
    event.eventable_type.should == @comment.class.to_s
  end
  it "Event Navigation" do
    event = Event.create(:eventable_type => 'Navigation', :user_id => @user.id)
    event.eventable_type.should == 'Navigation'
  end

end
