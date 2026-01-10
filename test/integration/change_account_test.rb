require "test_helper"

class ChangeAccountTest < ActionDispatch::IntegrationTest
  setup(&:sign_in)

  test "should work as expected" do
    get edit_user_url(User.first)
    assert_dom "h2", "Change account"

    patch user_url(User.first), params: {
      user: {
        password: "password",
        password_confirmation: "password"
      }
    }

    follow_redirect!
    assert_dom "p", "Your account was changed."
  end
end
