require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
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

  # 管理者がdeleteリクエストを送信してユーザー数が減ることのテスト
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      # 権限がない人にはdeleteリンクが存在
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    # deleteアクションを送ると、ユーザー数が1減る。
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  # 非権限者にはdeleteリンクが存在しないことのテスト
  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    # deleteリンクが存在しない。
    assert_select 'a', text: 'delete', count: 0
  end
end
