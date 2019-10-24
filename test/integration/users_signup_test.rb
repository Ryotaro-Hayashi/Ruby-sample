require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # 無効なユーザー登録に対するテスト
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

  # 有効なユーザー登録に対するテスト
  test "valid signup information" do
    get signup_path
    # 第二引数はオプションで、比較した結果の差異を渡す。
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    # POSTリクエストを送信した結果を見て、指定されたリダイレクト先に移動するメソッド
    follow_redirect!
    assert_template 'users/show'
  end
end
