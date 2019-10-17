# テストで使うデフォルト設定としてtest_helper.rbが読み込まれる
require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # setupメソッドに、テスト実行前に毎回実行してほしい処理を記述
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  # testメソッドは引数に文字列とブロックを受け付ける
  test "should be valid" do
    # assert メソッドは、第1引数がtrue である場合に、テストが成功したものとみなす
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
end
