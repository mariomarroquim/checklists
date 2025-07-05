require "test_helper"

class ChecklistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @checklist = checklists(:one)

    user = users(:one)
    password = "password"
    post session_url, params: { email_address: user.email_address, password: }
  end

  test "should get index" do
    get checklists_url
    assert_response :success
  end

  test "should get new" do
    get new_checklist_url
    assert_response :success
  end

  test "should create checklist" do
    assert_difference("Checklist.count") do
      post checklists_url, params: { checklist: { content: "Test", title: "Test" } }
    end

    assert_redirected_to checklists_url
  end

  test "should get edit" do
    get edit_checklist_url(@checklist)
    assert_response :success
  end

  test "should update checklist" do
    patch checklist_url(@checklist), params: { checklist: { content: @checklist.content, title: @checklist.title } }
    assert_redirected_to checklists_url
  end

  test "should destroy checklist" do
    assert_difference("Checklist.count", -1) do
      delete checklist_url(@checklist)
    end

    assert_redirected_to checklists_url
  end
end
