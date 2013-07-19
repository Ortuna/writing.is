Writing::Application.routes.draw do
  root 'application#index'

  get '/user/login', to: 'users#login'
  get '/user/login/callback',  to: 'omniauth_github#callback'
  get '/auth/github/callback', to: 'omniauth_github#callback'

  resources :books
end
