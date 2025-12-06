require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get new_user_url
    assert_dom "h2", "Sign up for free!"

    post users_url, params: {
      user: {
        email_address: "admin@example.com",
        password: "password",
        password_confirmation: "password"
      }
    }

    follow_redirect!
    assert_dom "p", "Please, add your first checklist!"
  end
end
