require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    # コントローラーを起動するためにgetメソッドで疑似的にHTTPリクエ
    get root_path
    # コントローラーを起動するためにgetメソッドで疑似的にHTTPリクエストを生成
    assert_response :success
    # CSSのセレクター式を指定して、第2引数と比較
    # タイトル要素が Ruby on Rails Tutorial Sample App であることをテスト
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end

end
