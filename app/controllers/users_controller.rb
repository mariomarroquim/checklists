class UsersController < ApplicationController
  rate_limit to: 1, within: 1.second, only: :create, with: -> { redirect_to new_user_url, alert: "Try again later." }

  allow_unauthenticated_access only: %i[ new create ]

  disallow_authenticated_access only: %i[ new create ]

  before_action :set_user, except: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url
    else
      flash.now[:alert] = "Try another email or match passwords."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @user.update(user_params.except(:email_address))
      redirect_to checklists_url, notice: "Your account was changed.", status: :see_other
    else
      flash.now[:alert] = "The passwords did not match."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session

    Current.user.destroy!

    redirect_to new_session_url, notice: "Your account was removed."
  end

  private
    def set_user
      @user = Current.user
    end

    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end
end
