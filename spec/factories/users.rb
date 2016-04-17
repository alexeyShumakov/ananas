FactoryGirl.define do
  factory :user do
    email 'test@mail.com'
    password  'password'
    password_confirmation  'password'
    confirmed_at Date.today
    role  0
  end
end
