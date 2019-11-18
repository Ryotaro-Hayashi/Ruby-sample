require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  # indexページでユーザーが表示されていて、ページネーション機能が実装されていることのテスト
  test "index including pagination" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    # divタグにpaginationクラスがあるかをテスト（ページネーションのリンクがある。）
    assert_select 'div.pagination'
    # ページにユーザーが存在する。
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end
end
