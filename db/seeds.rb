categories = %w(кухня науки мода мобильное здоровье бизнес путешествия)
categories.each do |category|
  cat = Category.create(title: category)
  3.times { Post.create(title: 'title', body: 'body', sinopsis: 'sinopsis', category: cat) }
end
