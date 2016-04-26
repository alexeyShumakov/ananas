namespace :utils do
  desc "send emails"
  task weekly_email: :environment do
    @users = User.where('weekly_mailing = ?', true).select(&:confirmed?)
    @users.each do |user|
      UserMailer.best_weekly(user).deliver_later
    end
  end

end
