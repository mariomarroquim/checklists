class ApplicationController < ActionController::Base
  include Authentication

  # Track who changed models.
  before_action :set_paper_trail_whodunnit

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Invalidate caches when the app version changes.
  etag { APP_VERSION }

  protected
    def find_checklist_by_id
      @checklist = Current.user.checklists.find(params.expect(:id))
    end

    def find_checklist_by_slug
      @checklist = Checklist.where(slug: params.expect(:slug)&.downcase).first

      if @checklist.nil? || @checklist.should_be_hidden?
        render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
      end
    end
end
