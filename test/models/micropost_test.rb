require 'test_helper'

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    # このコードは慣習的に正しくない
    # マイクロポストの作成
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end

  
end
