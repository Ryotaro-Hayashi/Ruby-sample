require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    # テンプレートが正しく表示されることを確認
    assert_template 'sessions/new'
    # わざと無効なparamsハッシュを使ってセッション用パスにPOSTする.
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    # フラッシュメッセージが追加されることを確認
    assert_not flash.empty?
    # 別のページに移動
    get root_path
    # 移動先のページでフラッシュメッセージが表示されていないことを確認
    assert flash.empty?
  end
end
