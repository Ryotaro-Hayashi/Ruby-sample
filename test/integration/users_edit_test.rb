require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    # edit_user_path にgetリクエストを送って、編集ページへ
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar" } }
    # ユーザー情報の更新に失敗してeditページが再レンダリングされる。
    assert_template 'users/edit'
  end

  tet 'successful edit' do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_template user_path(@puser)
    # データベースから最新のユーザー情報を読み直す。
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
