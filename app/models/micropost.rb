class Micropost < ApplicationRecord
  # コマンドでマイクロポストモデルを作るオプションで
  # user:references と指定したので自動生成で、
  # micropostモデルをユーザーモデルと結び付けてくれる。
  # belongs_to は１対１の関係であることを表す。
  belongs_to :user
  # ユーザーid の存在を検証
  validates :user_id, presence: true
  # マイクロポストが存在し、文字数が最大で140文字であることを検証
  validates :content, presence: true, length: { maximum: 140 }
  # default_scopeメソッドを使って、データベースから要素を取得したときの、デフォルトの順序を指定するメソッド
  # 引数にorderを与えて特定の順番にする。
  # デフォルトだと昇順で、古いものが初めにくるので、created_at: :descで降順にする。
  default_scope -> { order(created_at: :desc) }
end
