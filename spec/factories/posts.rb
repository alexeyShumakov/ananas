FactoryGirl.define do
  factory :post do
    sinopsis "MyString"
    avatar Rack::Test::UploadedFile.new("#{Rails.root}/public/images/post/medium/missing.png", "image/png")
    body "MyString"
    title "MyString"
    category
    user
  end
end
