class User < ApplicationRecord
  # validatesメソッドを使って値チェックの定義を設定
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 }
end
