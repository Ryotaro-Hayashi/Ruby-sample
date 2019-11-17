module UsersHelper

  # 引数で与えられたユーザーのGravatar画像を返す
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    # GravatarのURLはユーザーのメールアドレスをMD5という仕組みでハッシュ化
    # Digestライブラリのhexdigestメソッドを使うと、MD5のハッシュ化が実現
    # MD5ハッシュでは大文字と小文字が区別されるので、Rubyのdowncaseメソッドを使ってhexdigestの引数を小文字に変換
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    # ユーザーのメールアドレスを組み込んだGravatar専用の画像パス
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
