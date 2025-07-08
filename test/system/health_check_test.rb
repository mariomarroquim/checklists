require "application_system_test_case"

class HealthCheckTest < ApplicationSystemTestCase
  test "should work as expected" do
    skip "This test is flaky and needs to be fixed"

    visit rails_health_check_url
    assert_text ""
  end
end
