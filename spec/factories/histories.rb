FactoryGirl.define do
  factory :history do
    user
    title "MyString"
    history "MyText"

    factory :invalid_history do
      title ''
    end
  end
end
