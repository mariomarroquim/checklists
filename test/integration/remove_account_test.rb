require "test_helper"

class RemoveAccountTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get edit_user_url(User.first)
    assert_dom "h2", "Change my account"

    delete user_url(User.first)

    follow_redirect!
    assert_dom "h2", "Sign in"
  end
end
