require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    # getメソッドを使ってユーザー登録ページにアクセス
    get signup_path
    # assert_no_differenceのブロックを実行する前後でUser.countの値が変わらないことをテスト
    assert_no_difference 'User.count' do
      # フォーム送信をテストするために、users_pathに対してPOSTリクエストを送信
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # 送信に失敗したときにnewアクションが再描画されるので、assert_templateを使ったテスト
    # assert_template は指定されたテンプレートファイルが選択されたかをテスト
    assert_template 'users/new'
  end
end
