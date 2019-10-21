# 単体テストは、アプリを構成するライブラリ（主にモデル）が正しく動作するかをテスト


require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test テスト名 do
  #   テストコード
  # end
  test "book save" do
    # Bookモデルのインスタンスを生成し、データベースに保存
    book = Book.new({
      isbn: '978-4-7741-4466-X',
      title: 'Ruby on Rails本格入門',
      price: 3100,
      publish: '技術評論社',
      published: '2017-02-14',
      dl:false
    })
    # Assertionメソッドは、結果のチェックを行うメソッドでtestブロックの中で最低1回呼び出さなければいけない。
    # assertメソッドは第1引数がtrueのときテストが成功したとみなす。

    # 保存に成功した場合、テストに成功。第2引数は、メッセージ。
    assert book.save, 'Failed to save'
  end
end
