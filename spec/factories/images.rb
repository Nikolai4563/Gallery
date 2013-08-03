FactoryGirl.define do
  factory :image do
    url { File.new(Rails.root + 'spec/fixtures/images/rails_img.png')}
  end
end