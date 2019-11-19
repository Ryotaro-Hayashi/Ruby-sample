require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @micropost = microposts(:orange)
  end

  # ログインしていないときにマイクロポストを作成しようとするときのテスト
  test "should redirect create when not logged in" do
    # POSTリクエストでマイクロポストを作成しようとしても、マイクロポストの数が変わらない
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    end
    assert_redirected_to login_url
  end

  # ログインしていないときにマイクロポストを削除しようとするときのテスト
  test "should redirect destroy when not logged in" do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@micropost)
    end
    assert_redirected_to login_url
  end
end
