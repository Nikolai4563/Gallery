# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  images_count :integer          default(0)
#  name         :string(255)
#

require 'spec_helper'
describe Category do

  before :each do
    @category = FactoryGirl.create(:category)
    @image = FactoryGirl.create(:image, :category => @category)
  end

  it { should have_many(:images) }
  it { should have_many(:subscribes) }
  it { should have_many(:users).through(:subscribes) }

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:name).of_type(:string)}
  it {have_db_column(:images_count).of_type(:integer)}

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it 'has a valid factory' do
    @category.should be_valid
  end
  it "has a don't valid" do
    Category.create(:name => nil).should_not be_valid
  end
  it 'has a images counter cache' do
    @category.reload
    @category.images_count.should == 1
  end
end
