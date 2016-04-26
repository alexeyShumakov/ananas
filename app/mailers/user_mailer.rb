class UserMailer < ApplicationMailer
  def best_weekly(user)
    @user = user
    @posts = Post.best_weekly.limit(5)
    mail(to: user.email, subject: 'Ананас. Лучшее за неделю.')
  end
end
