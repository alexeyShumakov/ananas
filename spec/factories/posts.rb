FactoryGirl.define do
  factory :post do
    sinopsis "MyString"
    avatar Rack::Test::UploadedFile.new("#{Rails.root}/public/images/post/medium/missing.png", "image/png")
    body "MyString"
    title "MyString"
    sequence :slug do |n|
      "test-#{n}-slug"
    end
    category
    user
  end
end
