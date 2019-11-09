class SessionsController < ApplicationController
  def new
  end

  def create
    # paramsは次のような入れ子ハッシュになっている。
    user = User.find_by(email: params[:session][:email].downcase)
    # authenticateメソッドで、引数に渡された文字列をハッシュ化した値と、データベース内にあるpassword_digestカラムの値を比較
    # 入力されたメールアドレスを持つユーザーがデータベースに存在し、かつ入力されたパスワードがそのユーザーのパスワードである場合
    if user && user.authenticate(params[:session][:password])
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
    else
      # エラーメッセージを作成する
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  end
end
