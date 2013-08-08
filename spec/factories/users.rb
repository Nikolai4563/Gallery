# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "aspirework#{n}@mail.ru" }
    password Devise.friendly_token[0,20]
    password_confirmation { password }
    image File.new("#{Rails.root}/spec/fixtures/images/rails_img.png")

  end
end
