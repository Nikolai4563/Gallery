require 'spec_helper'
describe Post do
  it { should have_many(:comments) }
  it { should have_many(:likes) }
  it { should belongs_to(:category) }
  it { should have_many(:users).through(:likes) }

  it {have_db_column(:id).of_type(:integer)}
  it {have_db_column(:category_id).of_type(:integer)}
  it {have_db_column(:likes_count).of_type(:integer)}
  it {have_db_column(:comments_count).of_type(:integer)}
  it {have_db_column(:url).of_type(:string)}

  it { should allow_mass_assignment_of(:url) }
  it { should allow_mass_assignment_of(:category_id) }
end