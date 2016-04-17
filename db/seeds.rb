categories = %w(кухня науки мода мобильное здоровье бизнес путешествия)
user = User.create(email: 'test@mail.com', password: 'password', password_confirmation: 'password', confirmed_at: Date.today)
categories.each do |category|
  cat = Category.create(title: category)
  3.times { Post.create(user: user, title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph(10), sinopsis: Faker::Hipster.paragraph, category: cat) }
end
