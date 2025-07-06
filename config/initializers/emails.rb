Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    user_name: "mariomarroquim@gmail.com",
    password: "your_password_here",
    authentication: "plain",
    enable_starttls_auto: true,
    enable_starttls: true
  }
end
