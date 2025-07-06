class SessionsController < ApplicationController
  rate_limit to: 2, within: 1.minute, only: :create, name: "minutely", with: -> { redirect_to new_session_path, alert: "Try again later." }
  rate_limit to: 4, within: 1.hour, only: :create, name: "hourly", with: -> { redirect_to new_session_path, alert: "Try again later." }
  rate_limit to: 8, within: 1.day, only: :create, name: "daily", with: -> { redirect_to new_session_path, alert: "Try again later." }
  rate_limit to: 16, within: 1.week, only: :create, name: "weekly", with: -> { redirect_to new_session_path, alert: "Try again later." }

  allow_unauthenticated_access only: %i[ new create ]

  def new; end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
