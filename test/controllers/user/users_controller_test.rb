require 'test_helper'

class User::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_users_show_url
    assert_response :success
  end

  test "should get edit" do
    get user_users_edit_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get user_users_unsubscribe_url
    assert_response :success
  end

end
