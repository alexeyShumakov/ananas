FactoryGirl.define do
  factory :category do
    title "MyString"
    factory :invalid_category do
      title nil
    end

    factory :new_category do
      title 'New title'
    end
  end
end
