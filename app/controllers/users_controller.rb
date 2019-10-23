class UsersController < ApplicationController
  # RailsのREST機能が有効になっていると、GETリクエストは自動的にshowアクションとして扱わ
  def show
    # params[:id]の部分は、たとえばユーザーidの1に置き換わる。
    @user = User.find(params[:id])
    # デバッガーメソッドを追加すると、デバッグが簡単に行える。
    # debugger
  end

  def new
    @user = User.new
  end

  # RESTful URI に応答するので、/usersへのPOSTリクエストはcreateアクションに送られる。
  def create
    # paramsでフォーム送信を受け取り、User.newを使って新しいユーザーオブジェクトを作成
    @user = User.new(params[:user]) # 実装は終わっていないことに注意!
    if @user.save
      # 保存の成功をここで扱う。
    else
      render 'new'
    end
  end
end
