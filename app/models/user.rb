# 検証ルールを書くモデルクラス
class User < ApplicationRecord
  before_save { self.email = email.downcase }
  # validatesメソッドを使って検証ルールを宣言
  # validates 検証対象のフィールド名, 検証名: 検証パラメーター
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  # セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるよう
  # ハッシュ化とは、ハッシュ関数を使って、入力されたデータを元に戻せない (不可逆な) データにする処理
  # has_secure_passwordには、仮想的なpassword属性とpassword_confirmation属性に対してバリデーションをする機能も(強制的に)追加されている
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
