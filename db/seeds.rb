categories = %w(кухня науки мода мобильное здоровье бизнес путешествия)
user = User.create(email: 'test@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Date.today)
categories.each do |category|
  cat = Category.create(title: category)
  3.times do
    post_params = {
      user: user,
      title: Faker::Hipster.sentence,
      body: Faker::Hipster.paragraph(10),
      avatar: File.new("#{Rails.root}/public/images/post/medium/missing.png"),
      sinopsis: Faker::Hipster.paragraph,
      category: cat
    }
    post = Post.create(post_params)
    5.times { Comment.create user: user, post: post, body: Faker::Hipster.paragraph }
  end
end
