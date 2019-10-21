# 統合テストは、複数のコントローラーにまたがって、ユーザーの実際の操作を追跡するような用途で利用する。
# 統合テストは、コマンドで生成する必要がある。
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end
end
