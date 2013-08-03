# == Schema Information
#
# Table name: images
#
#  id             :integer          not null, primary key
#  category_id    :integer
#  likes_count    :integer          default(0)
#  comments_count :integer          default(0)
#  url            :string(255)
#

require 'spec_helper'
describe Image do

  before :each do
    @category = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    @category.users << @user
    @image = FactoryGirl.create(:image, :category => @category)
    @image.comments << FactoryGirl.create(:comment_user, :image => @image)

    @like = @user.likes << Like.create( :image_id => @image.id)
    @comment = @image.comments << FactoryGirl.create(:comment_user, :image => @image)
  end

  it { should have_many(:comments) }
  it { should have_many(:likes) }
  it { should belong_to(:category) }
  it { should have_many(:users).through(:likes) }

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:category_id).of_type(:integer)}
  it {have_db_column(:likes_count).of_type(:integer)}
  it {have_db_column(:comments_count).of_type(:integer)}
  it {have_db_column(:url).of_type(:string)}

  it { should allow_mass_assignment_of(:url) }
  it { should allow_mass_assignment_of(:category_id) }

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:category_id) }

  it "has a valid factory" do
    @image.should be_valid
  end
  it "has a don't valid" do
    Image.create(:url => nil).should_not be_valid
  end
  it "has a don't 2 valid" do
    Image.create(:url => 'images/rails_img.png', :category_id => nil).should_not be_valid
  end
  it "has a comments counter cache" do
    @image.reload
    @image.comments_count.should == 2
  end
  it "has a likes counter cache" do
    @image.reload
    @image.likes_count.should == 1
  end
  it "mailer test" do
    @image.send_mail
    ActionMailer::Base.deliveries.last.to.should == [@user.email]
  end
end
