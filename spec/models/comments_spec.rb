require 'spec_helper'
describe Comment do

  it { should belong_to(:commentable) }
  it { should belong_to(:image) }
  it { should have_many(:events).dependent(:destroy) }

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:commentable_id).of_type(:integer)}
  it {have_db_column(:commentable_type).of_type(:string)}
  it {have_db_column(:image_id).of_type(:integer)}
  it {have_db_column(:body).of_type(:string)}
  it {have_db_column(:created_at).of_type(:datetime)}
  it {have_db_column(:updated_at).of_type(:datetime)}

  it { should allow_mass_assignment_of(:body) }
  it { should allow_mass_assignment_of(:commentable_type) }
  it { should allow_mass_assignment_of(:commentable_id) }

  it { should validate_presence_of(:body) }
  it { should validate_presence_of(:commentable_type) }
  it { should validate_presence_of(:commentable_id) }

  context "Validate" do

    before :each do
      @category = FactoryGirl.create(:category)
      @image = FactoryGirl.create(:image, :category => @category)
      @comment = FactoryGirl.create(:comment_user, :image => @image)
    end

    it "has a don't valid" do
     Comment.create(:body => nil, :commentable_type => 'User' ).should_not be_valid
    end
    it "has a don't valid" do
      Comment.create(:body => 'Hello', :commentable_type => 'User').should_not be_valid
      end
    it "has a don't valid" do
     @image.comments.create(:body => 'Hello', :commentable_type => 'User', :commentable_id => 1).should be_valid
    end

  end
end
