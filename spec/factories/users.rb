FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password  'password'
    password_confirmation  'password'
    confirmed_at Date.today
    role  0

    factory :major_moderator do
      role 1
    end

    factory :minor_moderator do
      role 2
    end
  end
end
