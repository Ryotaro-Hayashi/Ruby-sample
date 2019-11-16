require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  # ログインしていないときに編集しようとするときのテスト
  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    # beforeフィルターによって実行されるlogged_in_userメソッドでフラッシュメッセージを表示
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  # ログインしていないときに直接ユーザー情報を更新しようとするときのテスト
  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

end
