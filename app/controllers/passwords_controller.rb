class PasswordsController < ApplicationController
  rate_limit to: 1, within: 10.minutes, only: :create, with: -> { redirect_to new_password_path, alert: "Try again later." }

  allow_unauthenticated_access

  disallow_authenticated_access

  before_action :set_user_by_token, only: %i[ edit update ]

  def new; end

  def create
    if user = User.find_by(email_address: params.expect(:email_address))
      PasswordsMailer.reset(user).deliver_later
    end

    redirect_to new_session_url, notice: "The recovery link was sent by email."
  end

  def edit; end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      start_new_session_for @user
      redirect_to after_authentication_url, notice: "The password was created."
    else
      redirect_to edit_password_url(params.expect(:token)), alert: "The passwords did not match."
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params.expect(:token))
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_url, alert: "The recovery link is invalid or expired."
    end
end
