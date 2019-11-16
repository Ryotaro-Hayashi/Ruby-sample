require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user       = users(:michael)
    @other_user = users(:archer)
  end

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

  # ログイン中のユーザーが別のユーザーを編集しようとするときのテスト
  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    # 別のユーザーを更新しようとする。
    get edit_user_path(@user)
    # beforeフィルターによって実行されるcorrect_userメソッドでフラッシュメッセージが表示
    assert flash.empty?
    assert_redirected_to root_url
  end

  # ログイン中のユーザーが別のユーザーを直接的に更新しようとするときのテスト
  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  # フレンドリーフォーワーディングのテスト
  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    # beforeフィルターでlogged_in_userが実行されてログインページがレンダリング
    log_in_as(@user)
    # ログイン前に開こうとしたeditページを表示
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    # 編集に成功するとupdateアクションでフラッシュメッセージが表示される。
    assert_not flash.empty?
    # updateアクションで user_path(@user)をレンダリング
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

end
