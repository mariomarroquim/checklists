require "test_helper"

class SignInTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get root_url
    follow_redirect!
    assert_dom "h2", "Sign in"

    post session_url, params: {
      email_address: "one@gmail.com",
      password: "password"
    }

    follow_redirect!
    assert_dom "h2", "My checklists"
  end
end
