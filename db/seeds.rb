categories = %w(кухня науки мода мобильное здоровье бизнес путешествия)
user = User.create(email: 'test@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Date.today)
categories.each do |category|
  cat = Category.create(title: category)
  3.times { Post.create(user: user, title: 'title', body: 'body', sinopsis: 'sinopsis', category: cat) }
end
