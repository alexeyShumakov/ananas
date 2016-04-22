categories      = %w(кухня науки мода мобильное здоровье бизнес путешествия)

admin           = User.create(email: 'admin@mail.com',           password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 1, is_admin: true)
user            = User.create(email: 'user@mail.com',            password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 0)
major_moderator = User.create(email: 'major_moderator@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 1)
minor_moderator = User.create(email: 'minor_moderator@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 2)

categories.each do |category|
  cat = Category.create(title: category)
  3.times do
    post_params = {
      user: major_moderator,
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
