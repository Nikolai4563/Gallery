require 'spec_helper'
describe Image do

  before do
    @image = FactoryGirl.build(:image)
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

  it { should validate_presence_of(:url)}

  it 'is invalid without a firstname' do
    Image.create(url: nil).should_not be_valid
  end

end