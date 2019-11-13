require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # fixtures を利用
  def setup
    @user = users(:michael)
    # （ユーザーを通した）マイクロポストの作成
    # buikd は、new と同じでデータベースへの保存は行われない。
    #  ユーザーを通してマイクロポストを作成しないと、ユーザーidが取得されない。
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  # ユーザーidがないときのマイクロポストのテスト
  test 'user id should be present' do
    # ユーザーidを空にする
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  # マイクロポストがスペースであるときのテスト
  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  # 140文字以上のマイクロポストのテスト
  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end
end
