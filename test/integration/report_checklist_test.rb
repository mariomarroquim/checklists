require "test_helper"

class ReportChecklistTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get public_checklist_url(slug: Checklist.first.slug)
    assert_dom "h2", Checklist.first.title

    post report_checklist_url(slug: Checklist.first.slug)

    follow_redirect!
    assert_dom "p", "This checklist was reported."
  end
end
