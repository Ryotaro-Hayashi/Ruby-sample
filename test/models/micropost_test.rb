require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  # fixtures を利用
  def setup
    @user = users(:michael)
    # このコードは慣習的に正しくない
    # マイクロポストの作成
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end

  test 'should be valid' do
    assert @micropost.valid?
  end

  # ユーザーidがないときのマイクロポストのテスト
  test 'user id should be present' do
    # ユーザーidを空にする
    @user.valid.user_id = nil
    assert_not @micropost.valid?
  end
end
