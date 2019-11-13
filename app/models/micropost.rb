class Micropost < ApplicationRecord
  # コマンドでマイクロポストモデルを作るのオプションで
  # user:references と指定したので自動生成で、
  # micropostモデルをユーザーモデルと結び付けてくれる。
  # belongs_to は１対１の関係であることを表す。
  belongs_to :user
  # ユーザーid の存在を検証
  validates :user_id, presence: true
  # マイクロポストが存在し、文字数が最大で140文字であることを検証
  validates :content, presence: true, length: { maximum: 140 }
end
