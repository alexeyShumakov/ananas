FactoryGirl.define do
  factory :history do
    name "MyString"
    email "MyString@email.com"
    history "MyText"

    factory :invalid_history do
      name ''
    end
  end
end
