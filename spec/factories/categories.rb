FactoryGirl.define do
  factory :category do
    title "MyString"
    factory :invalid_category do
      title nil
    end
  end
end
