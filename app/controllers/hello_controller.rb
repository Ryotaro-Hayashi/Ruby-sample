class HelloController < ApplicationController
  def index
    # テンプレート変数は、テンプレートファイルに埋め込むべき値のこと
    # Railsでは、インスタンス変数がその役割を担う。
    # アクションとビューでデータを受け渡しする橋渡し
    @msg = "こんにちは！"
  end

  def list
    # allメソッドでBookオブジェクトの配列返し、ビューに引き渡すためにインスタンス変数を使用
    @book = Book.all
  end
end
