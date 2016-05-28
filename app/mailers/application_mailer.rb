class ApplicationMailer < ActionMailer::Base
  default from: '"Ананас" <no-replay@ananas-journal.ru>', subject: 'Журнал "Ананас"'
  layout 'mailer'
end
