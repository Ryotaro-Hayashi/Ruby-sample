class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    # モデル内にpassword_digest（データベースの属性）が含まれていることで、has_secure_passwordというRailsのメソッドを呼び出せる。
    add_column :users, :password_digest, :string
  end
end
