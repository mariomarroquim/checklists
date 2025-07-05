class ChecklistsController < ApplicationController
  before_action :set_checklist, only: %i[ edit update destroy ]

  def index
    @checklists = Current.user.checklists.order(:title).all
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

  def destroy
    @checklist.destroy!
    redirect_to checklists_path, notice: "Your checklist was successfully removed.", status: :see_other
  end

  private
    def set_checklist
      @checklist = Current.user.checklists.find(params[:id])
    end

    def checklist_params
      params.require(:checklist).permit(:title, :content)
    end
end
