require 'test_helper'

class User::HashtagsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get user_hashtags_show_url
    assert_response :success
  end

end
