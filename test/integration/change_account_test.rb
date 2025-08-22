require "test_helper"

class ChangeAccountTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get edit_user_url(User.first)
    assert_dom "h2", "Change my account"

    patch user_url(User.first), params: {
      user: {
        password: "12345678",
        password_confirmation: "12345678"
      }
    }

    follow_redirect!
    assert_dom "p", "Your account was changed."
  end
end
