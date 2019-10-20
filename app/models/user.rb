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
end
