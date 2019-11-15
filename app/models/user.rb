# 検証ルールを書くモデルクラス
class User < ApplicationRecord
  # ユーザーがマイクロポストを複数所有する関連付け
  # has_manyメソッドにオプションを渡してあげることで、マイクロポストはユーザーと一緒に破棄される。
  # dependent: :destroyというオプションを使うと、ユーザーが削除されたときに、そのユーザーに紐付いたマイクロポストも一緒に削除されるようになる。
  has_many :microposts, dependent: :destroy
  before_save { self.email = email.downcase }
  # validatesメソッドを使って検証ルールを宣言
  # validates 検証対象のフィールド名, 検証名: 検証パラメーター
  # presence: true は、nilや空文字でないことを検証する
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるよう
  # ハッシュ化とは、ハッシュ関数を使って、入力されたデータを元に戻せない (不可逆な) データにする処理
  # has_secure_passwordには、仮想的なpassword属性とpassword_confirmation属性に対してバリデーションをする機能も(強制的に)追加されている
  has_secure_password
  # password が存在し、最低6文字であるという検証ルール
  validates :password, presence: true, length: { minimum: 6 }

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    # costは、ハッシュを算出するための計算コストを指定
    # テスト中は最小にし、本番環境ではしっかりと計算
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    # パスワードを作成（stringはハッシュ化する文字列）
    BCrypt::Password.create(string, cost: cost)
  end
end
