categories      = %w(кухня науки мода мобильное здоровье бизнес путешествия)

admin           = User.create(weekly_mailing: true, username: 'admin', email: 'admin@mail.com',
                              password: 'password', password_confirmation: 'password', confirmed_at: Date.today,
                              role: 1, is_admin: true)
user            = User.create(weekly_mailing: true, username: 'user',  email: 'user@mail.com',
                              password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 0)
major_moderator = User.create(weekly_mailing: true, username: 'major', email: 'major_moderator@mail.com',
                              password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 1)
minor_moderator = User.create(weekly_mailing: true, username: 'minor', email: 'minor_moderator@mail.com',
                              password: 'password', password_confirmation: 'password', confirmed_at: Date.today, role: 2)

categories.each do |category|
  cat = Category.create(title: category)
  5.times do
    post_params = {
      user: major_moderator,
      title: Faker::Hipster.sentence,
      body: Faker::Hipster.paragraph(10),
      avatar: File.new("#{Rails.root}/public/images/post/medium/missing.png"),
      sinopsis: Faker::Hipster.paragraph,
      category: cat
    }
    post = Post.create(post_params)
    5.times { Comment.create user: user, commentable: post, body: Faker::Hipster.paragraph }
  end
end

5.times do
  history_params = {
    user: major_moderator,
    title: Faker::Hipster.sentence,
    history: Faker::Hipster.paragraph(10)
  }
  history = History.new(history_params)
  5.times { Comment.create user: user, commentable: history, body: Faker::Hipster.paragraph }
end
