FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password  'password'
    password_confirmation  'password'
    confirmed_at Date.today
    role  0
  end
end
