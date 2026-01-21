class SessionsController < ApplicationController
  rate_limit to: 1, within: 1.second, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  allow_unauthenticated_access only: %i[ new create ]

  disallow_authenticated_access only: %i[ new create ]

  def new; end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_url, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_url
  end
end
