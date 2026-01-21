class ReportsController < ApplicationController
  allow_unauthenticated_access only: :create

  rate_limit to: 1, within: 1.second, only: :create, with: -> { redirect_to public_checklist_url(params.expect(:slug)), alert: "Try again later." }

  before_action :find_checklist_by_slug

  def create
    if authenticated? && Current.user == @checklist.user
      redirect_to public_checklist_url(@checklist.slug), alert: "You cannot report your checklists."
      return
    end

    if session[:reports]&.include?(@checklist.slug)
      redirect_to public_checklist_url(@checklist.slug), notice: "You already reported this checklist."
      return
    end

    @checklist.increment!(:reports)

    session[:reports] ||= []
    session[:reports] << @checklist.slug

    redirect_to public_checklist_url(@checklist.slug), notice: "This checklist was reported."
  end
end
