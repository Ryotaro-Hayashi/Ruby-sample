require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get signup_path" do
    get users_new_url
    assert_response :success
  end

end
