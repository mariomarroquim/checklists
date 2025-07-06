class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: "Password recovery link", to: user.email_address
  end
end
