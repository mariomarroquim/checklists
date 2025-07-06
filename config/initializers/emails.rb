# Be sure to restart your server when you modify this file.

# Email configuration for the application.
# This initializer sets up the Action Mailer to use SMTP with Gmail.

Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: "mariomarroquim@gmail.com",
    password: ENV['GOOGLE_APP_PASSWORD'],
    authentication: "plain",
    enable_starttls_auto: true,
    enable_starttls: true
  }
end
