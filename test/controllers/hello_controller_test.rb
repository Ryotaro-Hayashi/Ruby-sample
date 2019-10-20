# 機能テストは、コントローラーの動作やテンプレートの出力をチェックするためのテスト
# 具体的には、HTTPリクエストを疑似的に作成することで、アクションを実行する。
# その結果、HTTPステータスやテンプレート変数、出力の構造までを確認し、ルート定義の多様性もチェック
require 'test_helper'

class HelloControllerTest < ActionDispatch::IntegrationTest
  test "list action" do
    # コントローラーを起動するためにgetメソッドで疑似的にHTTPリクエストを生成
    get hello_path
    assert_equel 10, assigns(:books).length, 'found rows is wrong.'
    # 指定されたHTTPステータスが返されたらテスト成功
    assert_response :success, 'list action failed.'
    assert_template hello_path
  end
end
