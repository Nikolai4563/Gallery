FactoryGirl.define do
  factory :comment do
    sequence :body do |n|
      "comment_#{n}"
    end
  end
  factory :comment_user, :parent => :comment do
    association :commentable, :factory => :user
  end
end