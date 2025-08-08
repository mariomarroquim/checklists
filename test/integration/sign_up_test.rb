require "test_helper"

class SignUpTest < ActionDispatch::IntegrationTest
  test "should work as expected" do
    get new_user_path
    assert_dom "h2", "Sign up for free!"

    post users_path, params: {
      user: {
        email_address: "example@gmail.com",
        password: "12345678",
        password_confirmation: "12345678"
      }
    }

    follow_redirect!
    assert_dom "h2", "My checklists"
  end
end
