class ChecklistsController < ApplicationController
  before_action :find_checklist_by_id, only: %i[ edit update publish unpublish destroy ]
  before_action :find_checklist_by_slug, only: %i[ show report ]

  allow_unauthenticated_access only: %i[ show report ]

  def index
    @checklists = Current.user.checklists.order(:title).all

    flash.now[:notice] = "You have no checklists. Add your first!" if @checklists.blank?
  end

  def show
    @checklist.increment!(:visits)

    render :show
  end

  def report
    if user_reported_checklist?
      redirect_to public_checklist_url(params.expect(:slug)), notice: "You have already reported this checklist."
      return
    end

    @checklist.increment!(:reports)

    session[:reports] ||= []
    session[:reports] << @checklist.slug

    redirect_to public_checklist_url(@checklist.slug), notice: "This checklist was successfully reported."
  end

  def new
    @checklist = Checklist.new
  end

  def edit; end

  def create
    @checklist = Checklist.new(checklist_params.merge(user: Current.user))

    if @checklist.save
      redirect_to checklists_path, notice: "Your checklist was successfully added."
    else
      flash.now[:alert] = "There was an error adding your checklist."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @checklist.update(checklist_params)
      redirect_to checklists_path, notice: "Your checklist was successfully changed.", status: :see_other
    else
      flash.now[:alert] = "There was an error changing your checklist."
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    if @checklist.update(published_at: Time.current)
      notice = "Your checklist was successfully published."
      notice += "<br/><small>Public URL: #{helpers.link_to public_checklist_url(slug: @checklist.slug), public_checklist_url(slug: @checklist.slug)}</small>"

      redirect_to checklists_path, notice:, status: :see_other
    else
      flash.now[:alert] = "There was an error publishing your checklist."
      render :edit, status: :unprocessable_entity
    end
  end

  def unpublish
    if @checklist.update(published_at: nil)
      redirect_to checklists_path, notice: "Your checklist was successfully unpublished.", status: :see_other
    else
      flash.now[:alert] = "There was an error unpublishing your checklist."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @checklist.destroy!
    redirect_to checklists_path, notice: "Your checklist was successfully removed.", status: :see_other
  end

  private
    def find_checklist_by_id
      @checklist = Current.user.checklists.find(params.expect(:id))
    end

    def find_checklist_by_slug
      @checklist = Checklist.where(slug: params.expect(:slug)&.downcase).where.not(published_at: nil).first

      if @checklist.nil? || (!user_reported_checklist? && @checklist.should_be_hidden?)
        render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
        nil
      end
    end

    def user_reported_checklist?
      @user_reported_checklist ||= session[:reports]&.include?(@checklist.slug)
    end

    def checklist_params
      params.require(:checklist).permit(:title, :content)
    end
end
