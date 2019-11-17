class UsersController < ApplicationController
  # before_actionメソッドを使って何らかの処理が実行される直前に特定のメソッドを実行
  # beforeフィルターはコントローラ内のすべてのアクションに適用されるので、onlyオプションによって制限
  # ユーザー情報を更新する前に、ユーザーがログインしているかを確認し、していなければログインページをレンダリング
  before_action :logged_in_user, only: [:edit, :update]
  # ユーザー情報を更新する前に、ユーザーが正しいかを確認し、正しくなければrootをレンダリング
  before_action :correct_user,   only: [:edit, :update]

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
    # paramsハッシュ全体を初期化するという行為はセキュリティ上、極めて危険だから
    @user = User.new(user_params)
    if @user.save
      # ユーザー登録でログインも同時にする。
      log_in @user
      # ユーザー登録完了時にフラッシュメッセージを追加
      # フラッシュメッセージのキーがメッセージタイプになる。
      flash[:success] = "Welcome to the Sample App!"
      # 引数URLで指定されたパスにジャンプ
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    # params でユーザーidを取ってくる。
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # update_attributesメソッドは属性のハッシュを受け取り、成功時には更新と保存を続けて同時に行う。
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def index
    # User.allを使ってデータベース上の全ユーザーを取得
    # ビューで使えるインスタンス変数@usersに代入
    @users = User.all
  end

  # privateキーワードで、外部から使えないようにする。
  private
    # :user属性を必須とし、名前、メールアドレス、パスワード、パスワードの確認の属性をそれぞれ許可し、それ以外を許可しない
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # beforeアクション

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        # 開こうとしていたURLを store_location メソッドで記録
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      # ログイン中のユーザーと同じでなければ、rootをレンダリング
      # current_user?メソッドを使用
      redirect_to(root_url) unless current_user?(@user)
    end
end
