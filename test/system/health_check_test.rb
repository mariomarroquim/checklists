require "application_system_test_case"

class HealthCheckTest < ApplicationSystemTestCase
  test "should work as expected" do
    visit rails_health_check_url
    assert_text ""
  end
end
