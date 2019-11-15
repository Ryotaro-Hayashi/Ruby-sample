class CreateMicroposts < ActiveRecord::Migration[5.1]
  def change
    create_table :microposts do |t|
      t.text :content
      # コマンドで、user:references と指定したので自動生成で、
      # 自動的にインデックスと外部キー参照付きのuser_idカラムが追加される。
      t.references :user, foreign_key: true

      t.timestamps
    end
    # indexに複数のカラムを設定する場合は、add_index テーブル名, [:カラム名1, :カラム名2, ・・・]
    # index とは、特定のカラムからデータを取得する際に、テーブルの中の特定のカラムのデータを複製し検索が行いやすいようにしたもの
    # createed_at というカラムを設定したのは、user_idに関連付けられたすべてのマイクロポストを作成時刻の逆順で取り出しやすくするため
    add_index :microposts, [:user_id, :created_at]
  end
end
