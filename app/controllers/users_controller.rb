class UsersController < ApplicationController
  # RailsのREST機能が有効になっていると、GETリクエストは自動的にshowアクションとして扱わ
  def show
    # params[:id]の部分は、たとえばユーザーidの1に置き換わる。
    @user = User.find(params[:id])
    # デバッガーメソッドを追加すると、デバッグが簡単に行える。
    # debugger
  end

  def new
  end
end
