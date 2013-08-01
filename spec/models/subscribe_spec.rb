# == Schema Information
#
# Table name: subscribes
#
#  id          :integer          not null, primary key
#  category_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Subscribe do
  before :each do
    @category = FactoryGirl.create(:category)
    @user = FactoryGirl.create(:user)
    @category.users << @user
    @image = FactoryGirl.create(:image, :category => @category)
  end
  it { should belong_to(:user) }
  it { should belong_to(:category) }

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:category_id).of_type(:integer)}
  it {have_db_column(:user_id).of_type(:integer)}

  it { should allow_mass_assignment_of(:category_id) }

  it { should validate_uniqueness_of(:category_id).scoped_to(:user_id) }

  it { Subscribe.count.should == 1  }

end
