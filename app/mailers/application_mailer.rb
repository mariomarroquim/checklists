class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_ADDRESS") { "example@gmail.com" }
  layout "mailer"
end
