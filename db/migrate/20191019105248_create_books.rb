# テーブルの作成や修正をするマイグレーションという機能を実行するためのマイグレーションファイル
# rails db:migrate でマイグレーションを実行
class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    # create_tableメソッドでbooksというテーブルを新規に作成
    create_table :books do |t|
      # それぞれの型を持つカラムを備える（ex string型のカラムisbn）
      t.string :isbn
      t.string :title
      t.integer :price
      t.string :publish
      t.date :published
      t.boolean :dl

      t.timestamps
    end
  end
end
