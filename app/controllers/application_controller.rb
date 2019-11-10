# ActionController::Baseクラスは、コントローラーの基本的な機能を提供するクラス
# リクエスト・レスポンス処理に関わる基盤部分を担ってくれる。
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # 以下はアクション（アクションメソッド）で、クライアントからのリクエストに対して具体的な処理を実行するためのメソッド
  def hello
    # renderメソッドは、文字列を出力する
    render html: "hello, world!"
  end

  # Sessionヘルパーモジュールを読み込む
  include SessionsHelper
end

# 端的に言うと、コントローラーは複数の関連するアクションをまとめたもの
