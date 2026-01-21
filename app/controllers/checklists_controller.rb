class ChecklistsController < ApplicationController
  allow_unauthenticated_access only: :show

  before_action :find_checklist_by_id, only: %i[ edit update destroy ]
  before_action :find_checklist_by_slug, only: :show

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

  def new
    @checklist = Checklist.new
  end

  def edit; end

  def create
    @checklist = Checklist.new(checklist_params.merge(user: Current.user))

    if @checklist.save
      redirect_to checklists_url, notice: "Your checklist was added."
    else
      flash.now[:alert] = "Adding your checklist failed."
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @checklist.update(checklist_params)
      redirect_to checklists_url, notice: "Your checklist was changed.", status: :see_other
    else
      flash.now[:alert] = "Changing your checklist failed."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @checklist.destroy!
    redirect_to checklists_url, notice: "Your checklist was removed.", status: :see_other
  end

  private
    def checklist_params
      params.require(:checklist).permit(:title, :content)
    end
end
