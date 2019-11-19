require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  # アプリケーションヘルパーを使用できるようにする。
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  # プロフィール画面の表示をテスト
  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    # h1タグの内部をテスト
    assert_select 'h1>img.gravatar'
    # response.body は、そのページの完全なHTML
    # assert_match は、引数を第二引数から探す。
    assert_match @user.microposts.count.to_s, response.body
    assert_select 'div.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    end
  end
end
