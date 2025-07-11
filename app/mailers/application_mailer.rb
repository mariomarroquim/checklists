class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("EMAIL_ADDRESS") { "from@example.com" }
  layout "mailer"
end
