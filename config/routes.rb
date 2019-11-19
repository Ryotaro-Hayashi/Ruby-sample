# railsでは、クライアントからの要求を受け取ると、ルーティングを利用して呼び出すべきコントローラー/アクションを決定する。
Rails.application.routes.draw do

  # ～/helloというURLが要求されたら、helloコントローラーのindexアクションを呼び出す。
  get '/hello',  to: 'hello#greet'
  get '/list',   to: 'hello#list'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'

  # RESTの原則に従う場合、リソースへの参照はリソース名とユニークなIDを使うのが普通
  # ユーザーをリソースとみなす場合、id=1のユーザーを参照するということは、/users/1というURLに対してGETリクエストを発行するということを意味する。
  # リソースを設定して、/users/1 のURLを有効化し、その他の名前付きルートなどが利用できるようになる。
  resources :users
  resources :microposts,          only: [:create, :destroy]

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
