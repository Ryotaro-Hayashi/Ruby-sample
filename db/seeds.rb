# サンプルユーザーの作成
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# サンプルユーザーを99個作成
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

# 最初の6人を抜き出す。
users = User.order(:created_at).take(6)
50.times do
  # 投稿内容は、Faker::Loremメソッドで作成
  content = Faker::Lorem.sentence(5)
  # 各ユーザーにマイクロポストを作成
  users.each { |user| user.microposts.create!(content: content) }
end
