# O/Rラッパーである Active Record を利用することで、DBのデータをオブジェクト経由で操作できる。
class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
  end
end
