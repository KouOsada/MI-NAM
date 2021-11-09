require 'test_helper'

class User::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get user_relationships_followings_url
    assert_response :success
  end

  test "should get followers" do
    get user_relationships_followers_url
    assert_response :success
  end

end
