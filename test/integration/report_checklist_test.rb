require "test_helper"

class ReportChecklistTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get public_checklist_page_url(Checklist.first.slug)
    assert_dom "h2", Checklist.first.title

    post public_checklist_reports_url(Checklist.first.slug)

    follow_redirect!
    assert_dom "p", "This checklist was reported."
  end
end
