require "test_helper"

class SignOutTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get root_url
    assert_dom "h2", "My checklists"

    delete session_url

    follow_redirect!
    assert_dom "h2", "Sign in"
  end
end
