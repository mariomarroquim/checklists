require "test_helper"

class ReportChecklistTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get public_checklist_url(checklist.slug)
    assert_dom "h2", checklist.title

    post checklist_reports_url(checklist)

    follow_redirect!
    assert_dom "p", "This checklist was reported."
  end
end
