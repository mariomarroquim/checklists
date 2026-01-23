require "test_helper"

class ReportChecklistTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get public_checklist_url(Checklist.first.slug)
    assert_dom "h2", Checklist.first.title

    post checklist_reports_url(checklist_id: Checklist.first)

    follow_redirect!
    assert_dom "p", "This checklist was reported."
  end
end
