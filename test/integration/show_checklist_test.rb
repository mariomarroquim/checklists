require "test_helper"

class ShowChecklistTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get public_checklist_url(checklist.slug)
    assert_dom "h2", checklist.title
  end
end
