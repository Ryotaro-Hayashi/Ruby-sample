# railsでは、クライアントからの要求を受け取ると、ルーティングを利用して呼び出すべきコントローラー/アクションを決定する。
Rails.application.routes.draw do  
  # ～/helloというURLが要求されたら、helloコントローラーのindexアクションを呼び出す。
  get '/hello',  to: 'hello#index'
  get '/list',   to: 'hello#list'

  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
end
