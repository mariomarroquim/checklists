class PublicationsController < ApplicationController
  before_action :find_checklist_by_id

  def create
    @checklist.update(published_at: Time.current)

    notice = "Your checklist was published."
    notice += "<br/><small>URL: #{helpers.link_to public_checklist_page_url(@checklist.slug), public_checklist_page_url(@checklist.slug)}</small>"

    redirect_to checklists_url, notice:, status: :see_other
  end

  def destroy
    @checklist.update(published_at: nil)

    redirect_to checklists_url, notice: "Your checklist was unpublished.", status: :see_other
  end
end
