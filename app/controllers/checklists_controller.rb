class ChecklistsController < ApplicationController
  rate_limit to: 1, within: 1.second, only: :report, with: -> { redirect_to public_checklist_url(params.expect(:slug)), alert: "Try again later." }

  allow_unauthenticated_access only: %i[ show report ]

  before_action :find_checklist_by_id, only: %i[ edit update publish unpublish destroy ]
  before_action :find_checklist_by_slug, only: %i[ show report ]

  def index
    @checklists = Current.user.checklists.order(:title).all

    flash.now[:notice] = "Please, <strong>#{helpers.link_to "add", new_checklist_path}</strong> your first checklist!" if @checklists.blank?
  end

  def show
    if authenticated? && Current.user == @checklist.user
      render :show
      return
    end

    if session[:visits]&.include?(@checklist.slug)
      render :show
      return
    end

    @checklist.increment!(:visits)

    session[:visits] ||= []
    session[:visits] << @checklist.slug

    render :show
  end

  def report
    if authenticated? && Current.user == @checklist.user
      redirect_to public_checklist_url(@checklist.slug), alert: "You cannot report your checklists."
      return
    end

    if session[:reports]&.include?(@checklist.slug)
      redirect_to public_checklist_url(params.expect(:slug)), notice: "You already reported this checklist."
      return
    end

    @checklist.increment!(:reports)

    session[:reports] ||= []
    session[:reports] << @checklist.slug

    redirect_to public_checklist_url(@checklist.slug), notice: "This checklist was reported."
  end

  def new
    @checklist = Checklist.new
  end

  def edit; end

  def create
    @checklist = Checklist.new(checklist_params.merge(user: Current.user))

    if @checklist.save
      redirect_to checklists_path, notice: "Your checklist was added."
    else
      flash.now[:alert] = "Adding your checklist failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @checklist.update(checklist_params)
      redirect_to checklists_path, notice: "Your checklist was changed.", status: :see_other
    else
      flash.now[:alert] = "Changing your checklist failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def publish
    if @checklist.update(published_at: Time.current)
      notice = "Your checklist was published."
      notice += "<br/><small>Public URL: #{helpers.link_to public_checklist_url(slug: @checklist.slug), public_checklist_url(slug: @checklist.slug)}</small>"

      redirect_to checklists_path, notice:, status: :see_other
    else
      flash.now[:alert] = "Publishing your checklist failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def unpublish
    if @checklist.update(published_at: nil)
      redirect_to checklists_path, notice: "Your checklist was unpublished.", status: :see_other
    else
      flash.now[:alert] = "Unpublishing your checklist failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @checklist.destroy!
    redirect_to checklists_path, notice: "Your checklist was removed.", status: :see_other
  end

  private
    def find_checklist_by_id
      @checklist = Current.user.checklists.find(params.expect(:id))
    end

    def find_checklist_by_slug
      @checklist = Checklist.where(slug: params.expect(:slug)&.downcase).where.not(published_at: nil).first

      if @checklist.nil? || @checklist.should_be_hidden?
        render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    end

    def checklist_params
      params.require(:checklist).permit(:title, :content)
    end
end
